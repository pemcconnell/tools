# aws-instance

Creates testing instance with the following around it:
- VPC with subnets (TODO)
- Security Group
- Elastic IP
- 


Requires the following environment variables to be provided:
```bash
export AWS_DEFAULT_REGION=eu-west-2
export AWS_ACCESS_KEY_ID=<access_key>
export AWS_SECRET_ACCESS_KEY=<secret_key>
export TF_VAR_tag="testing"
export TF_VAR_availability_zone="eu-west-2a"
export TF_VAR_instance_type="t2.nano"
export TF_VAR_elastic_ip_id="eipalloc-12345678"
export TF_VAR_subnet_id="subnet-12345678"
export TF_VAR_security_group_ids="sg-122345678"
export TF_VAR_ssh_pub_key_file="~/.ssh/id_rsa.pub"
```