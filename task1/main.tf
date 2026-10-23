module "ec2" {
  source = "./modules/ec2"

  ami_id    = var.ami_id
  subnet_id = var.subnet_id

  instances = {
    dev-app = {
      instance_type = "t3.micro"
      volume_type   = "gp3"
      volume_size   = 10
      key_name      = "dev-key"
      environment   = "Dev"
      owner         = "satya-dev"
    }

    test-app = {
      instance_type = "t3.micro"
      volume_type   = "gp3"
      volume_size   = 10
      key_name      = "test-key"
      environment   = "Test"
      owner         = "satya-test"
    }

    stage-app = {
      instance_type = "t3.small"
      volume_type   = "gp3"
      volume_size   = 10
      key_name      = "stage-key"
      environment   = "Staging"
      owner         = "satya-stag"
    }

    qa-app = {
      instance_type = "t3.small"
      volume_type   = "gp3"
      volume_size   = 10
      key_name      = "qa-key"
      environment   = "QA"
      owner         = "satya-qa"
    }

    prod-app = {
      instance_type = "t3.small"
      volume_type   = "io1"
      volume_size   = 20
      key_name      = "prod-key"
      environment   = "Production"
      owner         = "satya-prod"
      protect       = "true"

    }
  }

}


