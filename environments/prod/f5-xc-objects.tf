# Create SMSv2 object
resource "volterra_securemesh_site_v2" "node-1" {
  name                    = "${var.prefix}-smsv2-node-1"
  namespace               = "system"
  description             = var.description
  block_all_services      = true
  logs_streaming_disabled = true
  enable_ha               = false
  labels = {
    "ves.io/provider" = "ves-io-AWS"
    "vsite"           = "${var.prefix}-aws-site"
  }
  re_select {
    geo_proximity = true
  }
  aws {
    not_managed {}
  }
  lifecycle {
    ignore_changes = [labels]
  }
}

# Create JWT tokens
resource "volterra_token" "node-1" {
  name       = "${var.prefix}-token-node-1"
  namespace  = "system"
  type       = 1
  site_name  = volterra_securemesh_site_v2.node-1.name
  depends_on = [volterra_securemesh_site_v2.node-1]
}

# Create cloud-config to be injected into cloud-init
data "cloudinit_config" "f5xc-ce_config-node-1" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content = yamlencode({
      #cloud-config
      write_files = [
        {
          path        = "/etc/vpm/user_data"
          permissions = "0644"
          owner       = "root"
          content     = <<-EOT
            token: ${replace(volterra_token.node-1.id, "id=", "")}
          EOT
        }
      ]
    })
  }
}

# Create SMSv2 object
resource "volterra_securemesh_site_v2" "node-2" {
  name                    = "${var.prefix}-smsv2-node-2"
  namespace               = "system"
  description             = var.description
  block_all_services      = true
  logs_streaming_disabled = true
  enable_ha               = false
  labels = {
    "ves.io/provider" = "ves-io-AWS"
    "vsite"           = "${var.prefix}-aws-site"
  }
  re_select {
    geo_proximity = true
  }
  aws {
    not_managed {}
  }
  lifecycle {
    ignore_changes = [labels]
  }
}

# Create JWT tokens
resource "volterra_token" "node-2" {
  name       = "${var.prefix}-token-node-2"
  namespace  = "system"
  type       = 1
  site_name  = volterra_securemesh_site_v2.node-2.name
  depends_on = [volterra_securemesh_site_v2.node-2]
}

# Create cloud-config to be injected into cloud-init
data "cloudinit_config" "f5xc-ce_config-node-2" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content = yamlencode({
      #cloud-config
      write_files = [
        {
          path        = "/etc/vpm/user_data"
          permissions = "0644"
          owner       = "root"
          content     = <<-EOT
            token: ${replace(volterra_token.node-2.id, "id=", "")}
          EOT
        }
      ]
    })
  }
}

# Create SMSv2 object
resource "volterra_securemesh_site_v2" "node-3" {
  name                    = "${var.prefix}-smsv2-node-3"
  namespace               = "system"
  description             = var.description
  block_all_services      = true
  logs_streaming_disabled = true
  enable_ha               = false
  labels = {
    "ves.io/provider" = "ves-io-AWS"
    "vsite"           = "${var.prefix}-aws-site"
  }
  re_select {
    geo_proximity = true
  }
  aws {
    not_managed {}
  }
  lifecycle {
    ignore_changes = [labels]
  }
}

# Create JWT tokens
resource "volterra_token" "node-3" {
  name       = "${var.prefix}-token-node-3"
  namespace  = "system"
  type       = 1
  site_name  = volterra_securemesh_site_v2.node-3.name
  depends_on = [volterra_securemesh_site_v2.node-3]
}

# Create cloud-config to be injected into cloud-init
data "cloudinit_config" "f5xc-ce_config-node-3" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content = yamlencode({
      #cloud-config
      write_files = [
        {
          path        = "/etc/vpm/user_data"
          permissions = "0644"
          owner       = "root"
          content     = <<-EOT
            token: ${replace(volterra_token.node-3.id, "id=", "")}
          EOT
        }
      ]
    })
  }
}

# Create Virtual Site
resource "volterra_virtual_site" "vs-name" {
  name        = "${var.prefix}-tf-vsite"
  namespace   = "shared"
  description = var.description
  site_type   = "CUSTOMER_EDGE"
  site_selector {
    expressions = ["vsite in (${var.prefix}-aws-site)"]
  }
}