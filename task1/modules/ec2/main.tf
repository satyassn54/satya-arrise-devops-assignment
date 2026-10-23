locals {
  protected_instances     = { for k, v in var.instances : k => v if v.protect }
  non-protected_instances = { for k, v in var.instances : k => v if !v.protect }
}

resource "aws_instance" "protected" {
  for_each      = local.protected_instances
  ami           = var.ami_id
  instance_type = each.value.instance_type
  key_name      = each.value.key_name
  subnet_id     = var.subnet_id

  root_block_device {
    volume_type = each.value.volume_type
    volume_size = each.value.volume_size
  }

  tags = {
    Name        = each.key
    Environment = each.value.environment
    Owner       = each.value.owner
  }

  lifecycle {
    prevent_destroy = true
  }
}


resource "aws_instance" "non-protected" {
  for_each      = local.non-protected_instances
  ami           = var.ami_id
  instance_type = each.value.instance_type
  key_name      = each.value.key_name
  subnet_id     = var.subnet_id

  root_block_device {
    volume_type = each.value.volume_type
    volume_size = each.value.volume_size
  }

  tags = {
    Name        = each.key
    Environment = each.value.environment
    Owner       = each.value.owner
  }
}
