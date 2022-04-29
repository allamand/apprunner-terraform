variable "name" {
  description = "(Required) Provide a name for reviewapps environment"
}
 
variable "stage" {
  description = "(Required) Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
}
 
variable "branch" {
  description = "(Required) Branch name on GitHub"
}
 
variable "port" {
  description = "(Optional) The port that your applicatio va  n listens to in the container. Default '3000'"
  default     = 8080
}