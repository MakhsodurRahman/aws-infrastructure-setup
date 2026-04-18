output "install_script" {
  description = "Docker installation script content"
  value       = file("${path.module}/install_docker.sh")
}
