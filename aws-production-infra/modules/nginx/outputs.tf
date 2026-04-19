output "install_script" {
  description = "Nginx installation script content"
  value       = file("${path.module}/install_nginx.sh")
}

output "nginx_version" {
  description = "The pinned Nginx version being installed"
  value       = "1.26.2"
}
