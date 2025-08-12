variable "instance_type" {
  type = string
}

variable "f5xc_api_p12_file" {
  type = string
}

variable "f5xc_api_url" {
  type = string
}

variable "description" {
  type = string
}

variable "prefix" {
  type = string
}

variable "owner" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "slo_subnet_1" {
  type = string
}

variable "slo_subnet_2" {
  type = string
}

variable "slo_subnet_3" {
  type = string
}

variable "sli_subnet_1" {
  type = string
}

variable "sli_subnet_2" {
  type = string
}

variable "sli_subnet_3" {
  type = string
}

variable "ami" {
  type = string
}

variable "existing_ssh_key_name" {
  type = string
}