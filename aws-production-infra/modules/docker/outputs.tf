output "install_script" {
  description = "Docker installation script content"
  value       = file("${path.module}/install_docker.sh")
}

output "docker_version" {
  description = "The pinned Docker version being installed"
  value       = "27.4.0"
}
