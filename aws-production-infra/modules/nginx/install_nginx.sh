# Install Nginx on Ubuntu (Pinned Version)
NGINX_VERSION="1.26.2"

# Add official Nginx signing key
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null

# Add repository
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/ubuntu $(lsb_release -cs) nginx" | tee /etc/apt/sources.list.d/nginx.list

apt-get update
apt-get install -y nginx=${NGINX_VERSION}-1~jammy

# Start and enable Nginx
systemctl start nginx
systemctl enable nginx

# Create a basic landing page
cat <<EOF > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to Nginx on AWS</title>
    <style>
        body { font-family: sans-serif; text-align: center; padding: 50px; background: #f4f4f4; }
        .card { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); display: inline-block; }
        h1 { color: #009639; }
    </style>
</head>
<body>
    <div class="card">
        <h1>Nginx ${NGINX_VERSION} successfully installed!</h1>
        <p>This instance is managed by Terraform.</p>
        <p>Environment: <strong>$(hostname)</strong></p>
    </div>
</body>
</html>
EOF

# Ensure health check endpoint works if needed
mkdir -p /usr/share/nginx/html/health
echo "OK" > /usr/share/nginx/html/health/index.html

echo "=========================================="
echo "  Nginx ${NGINX_VERSION} installed!  "
echo "=========================================="
