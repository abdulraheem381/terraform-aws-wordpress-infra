variable "instance_type" {

  type        = string
  description = "EC2 Instance type"
  default = "t2.micro"

  validation {
    condition     = var.instance_type == "t2.micro" || var.instance_type == "t3.micro"
    error_message = "Only t2.micro & t3.micro is allowed"
  }
}


variable "volume_size" {

  type    = number
  default = 10

}

variable "volume_type" {

  type    = string
  default = "gp2"

}


variable "additional_tags" {

  type    = map(string)
  default = {}

}