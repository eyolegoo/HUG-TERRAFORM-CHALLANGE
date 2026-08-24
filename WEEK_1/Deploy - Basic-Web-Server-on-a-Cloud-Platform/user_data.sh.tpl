#!/bin/bash
set -euo pipefail

# Update packages and install Nginx (Amazon Linux 2 / 2023 use dnf or yum)
if command -v dnf >/dev/null 2>&1; then
  dnf update -y
  dnf install -y nginx
else
  yum update -y
  amazon-linux-extras install -y nginx1 || yum install -y nginx
fi

# Write the landing page
cat > /usr/share/nginx/html/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>${event_name}</title>
  <style>
    body {
      font-family: Arial, Helvetica, sans-serif;
      background: linear-gradient(135deg, #1f4037, #99f2c8);
      color: #ffffff;
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100vh;
      margin: 0;
      text-align: center;
    }
    .card {
      background: rgba(0, 0, 0, 0.45);
      padding: 40px 60px;
      border-radius: 12px;
      box-shadow: 0 4px 20px rgba(0,0,0,0.3);
    }
    h1 { font-size: 2.2em; margin-bottom: 10px; }
    h2 { font-size: 1.4em; font-weight: normal; }
  </style>
</head>
<body>
  <div class="card">
    <h1>${full_name}</h1>
    <h2>${event_name}</h2>
  </div>
</body>
</html>
EOF

# Enable and start Nginx
systemctl enable nginx
systemctl start nginx
