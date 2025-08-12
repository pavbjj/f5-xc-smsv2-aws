prefix                = "p-kuligowski-aws"   # Prefix for all objects in the project
description           = "Managed by ADO" # description of all XC resources
instance_type         = "m5.2xlarge"     # 	MEDIUM: m5.2xlarge	LARGE: m5.4xlarge
region                = "us-east-1"      # Azure location
slo_subnet_1          = "subnet-0f68393fab9e103d2"
slo_subnet_2          = "subnet-0163c7e326911ea78"
slo_subnet_3          = "subnet-04dd0b321138c86a4"
sli_subnet_1          = "subnet-0cf6159e6ee8d48ee"
sli_subnet_2          = "subnet-036f602910075ebc4"
sli_subnet_3          = "subnet-0f1d5f5c8a4ef1e22"
vpc_id                = "vpc-049fd084a6377386a"
owner                 = "p.kuligowski@f5.com"
ami                   = "ami-05a5dc7a99d755991"
existing_ssh_key_name = "p-kuligowski-macbook"

# XC provider vars
f5xc_api_p12_file = "./p12.p12"                                      # location of XC .p12 file
f5xc_api_url      = "https://f5-consult.console.ves.volterra.io/api" # XC tenant e.g. "https://f5-consult.console.ves.volterra.io/api"