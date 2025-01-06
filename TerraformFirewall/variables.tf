resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  auto_create_subnetworks = true
}
variable "project" {
  description = "The project ID"
  type = string
}
variable "region" {
  description = "The region"
  type = string
}
variable "zone" {
  description = "The zone"
  type = string
}