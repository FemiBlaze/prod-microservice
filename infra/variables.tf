variable "image_tag" {
  description = "Docker image tag"
  type        = string
  default     = "latest"
}
variable "desired_count" {
  description = "Number of ECS tasks"
  type        = number
  default     = 1
}

