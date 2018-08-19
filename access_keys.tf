The file terraform.tfvars should only live on your local computer and never checked into source control.
It is very important that terraform.tfvars is placed in your .gitignore file.
So we have a few changes to the files. I’ll start with aws.tf again. Here we have separately defined both access keys.

provider "aws" {
access_key = "${var.aws_access_key}"
secret_key = "${var.aws_secret_key}"
region     = "${var.region}"
}

resource "aws_instance" "web-server" {
ami           = "ami-0c2aba6c"
instance_type = "t2.micro"

  tags {
    Name = "terraformtraining.com"
  }
}
Here we define the variables, note the access and secret key are blank.

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "region" {
        default = "us-west-2"
}
And finally we have the terraform.tfvars file.

aws_access_key = "ENTER-YOUR-ACCESS-KEY-HERE"
aws_secret_key = "ENTER-YOUR-SECRET-KEY-HERE"
So now Terraform picks up the credentials from the terraform.tfvars file and authenticates correctly.

[markb@feddy demo.2a] $ ll
total 12
-rw-rw-r--. 1 markb markb 271 Jul 24 16:43 aws.tf
-rw-rw-r--. 1 markb markb 100 Jul 24 16:45 terraform.tfvars
-rw-rw-r--. 1 markb markb 132 Jul 24 16:43 vars.tf
[markb@feddy demo.2a] $ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

The Terraform execution plan has been generated and is shown below.
Resources are shown in alphabetical order for quick scanning. Green resources
will be created (or destroyed and then created if an existing resource
exists), yellow resources are being changed in-place, and red resources
will be destroyed. Cyan entries are data sources to be read.

Note: You didn't specify an "-out" parameter to save this plan, so when
"apply" is called, Terraform can't guarantee this is what will execute.

+ aws_instance.web-server
    ami:                          "ami-0c2aba6c"
    associate_public_ip_address:  "<computed>"
    availability_zone:            "<computed>"
    ebs_block_device.#:           "<computed>"
    ephemeral_block_device.#:     "<computed>"
    instance_state:               "<computed>"
    instance_type:                "t2.micro"
    ipv6_address_count:           "<computed>"
    ipv6_addresses.#:             "<computed>"
    key_name:                     "<computed>"
    network_interface.#:          "<computed>"
    network_interface_id:         "<computed>"
    placement_group:              "<computed>"
    primary_network_interface_id: "<computed>"
    private_dns:                  "<computed>"
    private_ip:                   "<computed>"
    public_dns:                   "<computed>"
    public_ip:                    "<computed>"
    root_block_device.#:          "<computed>"
    security_groups.#:            "<computed>"
    source_dest_check:            "true"
    subnet_id:                    "<computed>"
    tags.%:                       "1"
    tags.Name:                    "terraformtraining.com"
    tenancy:                      "<computed>"
    volume_tags.%:                "<computed>"
    vpc_security_group_ids.#:     "<computed>"


Plan: 1 to add, 0 to change, 0 to destroy.
There are even more ways to authenticate against AWS using Terraform, notably using AWS IAM roles but I won’t go into that just now.