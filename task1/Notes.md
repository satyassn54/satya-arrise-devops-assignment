**Task1:**

. Here, we are using module 'ec2' to provision and manage ec2 instances.  
. All five instances are configured through one instances map.
. 'prod-app' uses an 'io1' root volume.
. Every instance has separate Name, Environment and Owner tags.
. We added lifecycle block for 'prod-app' instance using the key 'protect = true', is protected from accidental Terraform destruction because it represents a production workload. Removing it from the configuration or changing its immutable properties can cause Terraform to fail rather than destroy it while the slifecycle protection remains in the configuration.
. Added 'output' block as required.
. You can override the 'region', 'ami-id' & 'subnet-id' in the terraform.tfvars file.

**Requirements or Validations**:

- **Single Input Variable:** All 5 instances are managed via a single map variable (`instances`) passed into the custom module, fulfilling the requirement for a clean modular block without hardcoding multiple resource blocks.

- **Lifecycle Protection Workaround:** Terraform does not allow dynamic expressions or conditions (`count.index` or `each.key`) inside a `lifecycle` block. To bypass this restriction while maintaining a unified module interface, the module uses `locals` to internally split the input map into two resource blocks: one equipped with `prevent_destroy = true` and the other with the "false" block.

- **'io1' or 'io2' storage usage**: Here 'prod-app' instance is using 'io1' storage type , Any instance without the usage of either io1 or io2 storage type will fail the validation.

- **Output** : The terraform output block will print the instance Name => Instance Id and in the other section, it will prints the Instance Name => and its private ip's.

**Commands :**

terraform fmt --recursive

terraform init

terraform validate

terraform plan

terraform apply
