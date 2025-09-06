variable "instance_type" {

  type        = string
  description = "EC2 Instance type"

  validation {
    condition     = var.instance_type == "t2.micro" || var.instance_type == "t3.micro"
    error_message = "Only t2.micro & t3.micro is allowed"
  }
}


variable "volume_size" {

  type    = number

}

variable "volume_type" {

  type    = string

}


variable "additional_tags" {

  type    = map(string)
  default = {}

}