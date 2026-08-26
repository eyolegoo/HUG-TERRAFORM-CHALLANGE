# Project 2 – Build Reusable Infrastructure with Terraform Modules

## HUG Lagos/Ibadan Terraform Challenge — Week 2

This project refactors [Week 1's](../WEEK_1) monolithic configuration into
four reusable Terraform modules (`vpc`, `networking`, `security`, `compute`)
and moves Terraform state from local disk to a remote S3 backend with
DynamoDB locking. The end result is the same as Week 1 — a public web
server running Nginx — but the code is now organized so each piece can be
reused, tested, or swapped independently.

## What Changed From Week 1

| Week 1 | Week 2 |
|---|---|
| Everything in one `main.tf` | Split into `modules/vpc`, `modules/networking`, `modules/security`, `modules/compute` |
| Local state (`terraform.tfstate` on disk) | Remote state in S3, locked via DynamoDB |
| Hardcoded relationships between resources | Modules communicate via explicit `variables` in and `outputs` out |
| One-off project | Root module can be reused for other environments (e.g. `dev`/`staging`) by just changing `terraform.tfvars` and the backend key |

## Architecture

```
                        Internet
                            │
                    ┌───────▼────────┐
                    │ Internet Gateway│   ← module.networking
                    └───────┬────────┘
                            │
                    ┌───────▼────────┐
                    │  Route Table    │   ← module.networking
                    └───────┬────────┘
                            │
        ┌───────────────────────────────────┐
        │      Custom VPC                    │   ← module.vpc
        │  ┌───────────────────────────────┐ │
        │  │  Public Subnet                 │ │   ← module.networking
        │  │                                │ │
        │  │   ┌────────────────────────┐  │ │
        │  │   │   EC2 Instance (Nginx)  │  │ │   ← module.compute
        │  │   │   Security Group        │  │ │   ← module.security
        │  │   └────────────────────────┘  │ │
        │  └───────────────────────────────┘ │
        └───────────────────────────────────┘

State: stored remotely in S3 (versioned + encrypted),
       locked via DynamoDB during apply/destroy.
```

## Project Structure

```
user@Godwin MINGW64 ~/Downloads/HUG-TERRAFORM-CHALLANGE/WEEK_2 (main)
$ tree
.
`-- Build-Reusable-Infrastructure-with-Modules
    |-- README.md
    |-- assets
    |   `-- images
    |       |-- wk2_1.png
    |       |-- wk2_10.png
    |       |-- wk2_2.png
    |       |-- wk2_3.png
    |       |-- wk2_4.png
    |       |-- wk2_5.png
    |       |-- wk2_6.png
    |       |-- wk2_7.png
    |       |-- wk2_8.png
    |       `-- wk2_9.png
    |-- backend-bootstrap
    |   |-- main.tf
    |   |-- outputs.tf
    |   |-- provider.tf
    |   |-- terraform.tfstate
    |   `-- variables.tf
    |-- backend.hcl
    |-- backend.hcl.example
    |-- main.tf
    |-- modules
    |   |-- compute
    |   |   |-- main.tf
    |   |   |-- outputs.tf
    |   |   |-- user_data.sh.tpl
    |   |   `-- variables.tf
    |   |-- networking
    |   |   |-- main.tf
    |   |   |-- outputs.tf
    |   |   `-- variables.tf
    |   |-- security
    |   |   |-- main.tf
    |   |   |-- outputs.tf
    |   |   `-- variables.tf
    |   `-- vpc
    |       |-- main.tf
    |       |-- outputs.tf
    |       `-- variables.tf
    |-- outputs.tf
    |-- provider.tf
    |-- terraform.tfvars
    |-- terraform.tfvars.example
    `-- variables.tf
```

## Prerequisites

1. An AWS account with permissions to create VPC, EC2, S3, and DynamoDB resources.
2. [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.5.0.
3. [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html), configured:
   ```bash
   aws configure
   ```
4. (Optional, for SSH) An existing EC2 key pair in your target region.

## Deployment Instructions

### Step 1 — Bootstrap the remote backend (one-time)

The S3 bucket and DynamoDB table that will hold Terraform's state need to
exist *before* the main project can use them as a backend, so they live in
a small, separate configuration.

```bash
cd backend-bootstrap
terraform init
terraform apply -var="state_bucket_name=your-unique-bucket-name"
```

Note the outputs — you'll need `state_bucket_name` and `lock_table_name` in
Step 2.

> S3 bucket names are globally unique across **all** AWS accounts, so pick
> something specific. So I used `godwin-hug-terraform-state-2026`.

```bash
terraform apply -var="state_bucket_name=godwin-hug-terraform-state-2026"
```

### Step 2 — Configure the backend for the main project

```bash
cd ..   # back to the project root
cp backend.hcl.example backend.hcl
```

Edit `backend.hcl` with the values from Step 1's outputs:

```hcl
bucket         = "your-unique-bucket-name"
key            = "hug-terraform-challenge/week2/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "hug-terraform-locks"
encrypt        = true
```

### Step 3 — Configure your variables

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars`:

```hcl
full_name        = "Your Firstname Lastname"
ssh_allowed_cidr = "YOUR_PUBLIC_IP/32"   # find it via `curl ifconfig.me`
key_name         = "HUG"                 # optional, "" to skip
instance_type    = "t3.micro"            # confirm Free Tier eligibility for your account
```

### Step 4 — Initialize with the remote backend

```bash
terraform init -backend-config="backend.hcl"
```

Terraform will confirm it's using the S3 backend. If you're migrating from
local state (e.g. re-running this after Week 1), it will offer to copy your
existing local state into S3 — say `yes`.

### Step 5 — Plan and apply

```bash
terraform plan
terraform apply
```

Type `yes` when prompted.

### Step 6 — Get the website URL

```
instance_public_ip = "x.x.x.x"
website_url         = "http://x.x.x.x"
```

Open it in a browser (allow ~60 seconds for `user_data` to finish).

### Step 7 — Verify remote state

```bash
aws s3 ls s3://your-unique-bucket-name/hug-terraform-challenge/week2/
```

You should see `terraform.tfstate` sitting in the bucket — confirming state
is no longer local.

### Step 8 — Tear down

```bash
terraform destroy
```

The backend bucket/table from Step 1 are intentionally **not** destroyed by
this command (they live in a separate configuration) so your state history
survives. Only destroy them manually via `backend-bootstrap` if you're fully
done with the project.

## How the Modules Fit Together

- **`module.vpc`** creates only the VPC and outputs its `vpc_id`.
- **`module.networking`** takes `vpc_id` as input and creates the public
  subnet, Internet Gateway, route table, and the association between them.
  It outputs `public_subnet_id`.
- **`module.security`** also takes `vpc_id` as input and creates the
  security group, outputting `security_group_id`.
- **`module.compute`** takes `public_subnet_id` and `security_group_id` as
  inputs, looks up the latest Amazon Linux 2023 AMI itself, launches the
  EC2 instance, and runs its own bundled `user_data.sh.tpl` to install
  Nginx and render the page.

This is a deliberate one-way dependency chain (`vpc → networking/security →
compute`) — Terraform builds the dependency graph automatically from these
module input/output references, so no manual `depends_on` is needed at the
root level.

## Why a Remote Backend

- **Team-safe**: state isn't sitting on one person's laptop; anyone with
  access to the S3 bucket can run `plan`/`apply` against the same state.
- **Locking**: DynamoDB prevents two `apply` runs from racing each other and
  corrupting state.
- **Durability & history**: S3 versioning means a bad apply's state can be
  rolled back to a previous version.
- **Encryption**: state (which can contain sensitive values) is encrypted
  at rest via SSE-S3.

## Screenshots

### Web Page
![Web page showing name and event](assets/images/webpage-screenshot.png)

### EC2 Instance Running (AWS Console)
![EC2 console showing instance running](assets/images/ec2-console-screenshot.png)

## Customization

Same variables as Week 1 — see `terraform.tfvars.example` for the full list
(`aws_region`, `vpc_cidr`, `public_subnet_cidr`, `availability_zone`,
`instance_type`, `key_name`, `ssh_allowed_cidr`, `full_name`, `event_name`).
