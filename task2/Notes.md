**Task2:**

. Since Task1, has no backend configuration, In this we are adding it.
. Creating the s3 bucket by enabling the versioning and encrypting it for security.
. Creating Dynamodb table too for state locking mechanism, so that parallel execution of terraform scripts should not be done. 
. Place the file "backend-task2.tf_create_this_in_task2" as 'backend.tf' in the task1 directory and then run the command below, to migrate the state.
					**terraform init -migrate-state**

. By approving "yes", this will migrate the state file from "local" to the "s3" backend.

**What happens today with local state?**
By default, Terraform stores your state in a local file named terraform.tfstate on your machine. 

If two engineers run terraform apply concurrently:
  State Overwrite (Race Condition): Both engineers pull the exact same local state at the start. Engineer A finishes first and uploads their new state file to disk. Engineer B finishes a moment later and overwrites Engineer A's state file with their own older baseline state.
  Resource Drift: Engineer B's state file completely erases the record of the resources Engineer A just created, causing desync between Terraform's tracking and actual cloud infrastructure, often leading to orphaned resources, deployment failures or accidental deletions.


**How the S3 + DynamoDB backend prevents this:**
Centralized Source of Truth (S3): The state file lives securely in an S3 bucket, ensuring everyone on the team is always reading and writing to the exact same version of infrastructure state.

State Locking (DynamoDB): When either engineer runs terraform apply, Terraform automatically attempts to write a lock item into the specified DynamoDB table using the state file's key.

If Engineer A acquires the lock first, Engineer B's run will immediately pause and display a message stating that the state is locked by another process.
Engineer B's apply will safely wait or fail cleanly until Engineer A's apply completes and automatically releases the lock. This entirely eliminates race conditions and state corruption.

