prefix                = "f5-aws"         # Prefix for all objects in the project
description           = "Managed by ADO" # description of all XC resources
instance_type         = "m5.2xlarge"     # 	MEDIUM: m5.2xlarge	LARGE: m5.4xlarge
region                = "us-east-1"      # AWS Region
slo_subnet_1          = ""
slo_subnet_2          = ""
slo_subnet_3          = ""
sli_subnet_1          = ""
sli_subnet_2          = ""
sli_subnet_3          = ""
vpc_id                = ""
owner                 = "p.kuligowski@f5.com"
ami                   = "ami-05a5dc7a99d755991"
existing_ssh_key_name = ""

# XC provider vars
f5xc_api_p12_file = "./p12.p12" # location of XC .p12 file
f5xc_api_url      = ""          # XC tenant e.g. "https://f5-consult.console.ves.volterra.io/api"