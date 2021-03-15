variable "vpc_cidr" {
    type = map(string)
    default = {
        prd = "10.1.0.0/16"
        dev = "10.2.0.0/16"
    }
}

variable "project"{
    type = string
    default = "connect"
}

variable "env" {
    type = string
    default = "dev"
}

variable "az" {
    type = map(string)
    default = {
        az_a = "ap-northeast-1a"
    }
}

variable "subnet_cidr" {
    type = map(string)
    default = {
        dev_public_a = "10.2.1.0/24"
    }
}