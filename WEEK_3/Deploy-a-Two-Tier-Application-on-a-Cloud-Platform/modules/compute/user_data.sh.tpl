#!/bin/bash
set -euo pipefail

# Update packages and install nginx
dnf update -y
dnf install -y nginx

# Deploy a simple HTML page
cat > /usr/share/nginx/html/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>${project_name} - Two-Tier App</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #0b1f3a;
      color: #ffffff;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      height: 100vh;
      margin: 0;
    }
    h1 { color: #4fd1c5; }
    p { font-size: 1.1em; }
    .badge {
      background: #4fd1c5;
      color: #0b1f3a;
      padding: 6px 14px;
      border-radius: 20px;
      font-weight: bold;
      margin-top: 20px;
    }
  </style>
</head>
<body>
  <h1>${project_name}</h1>
  <p>Deployed by Godwin Williams</p>
  <p>HUG Lagos/Ibadan Terraform Challenge.</p>
  <div class="badge">Status: Healthy</div>
</body>
</html>
EOF

# Enable and start nginx
systemctl enable nginx
systemctl start nginx
