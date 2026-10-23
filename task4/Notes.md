**Task4:**

. Created the file 'ci-user-pipeline-policy.json' with the neccessary and least privilege policy for IAM permissions.

. You can add this file in the task3 directory and use the resource block as mentioned in the main.tf file.

**Imp Notes:**

**I. Global ECR and ECS Wildcards (\*):**
Not given: Broad permissions like ecr:* or ecs:* across all resources.
Why: If the CI user's credentials were compromised, an attacker could tamper with delete or create unauthorized container repositories and services across the entire AWS account. Scoping ECR to a specific repository ARN and ECS to a specific cluster/service name minimizes the blast radius.

**II. S3 Write Permissions on the Artifact Bucket:**

Not given - Write/modify (s3:PutObject, s3:DeleteObject, etc.) access to the build artifacts bucket.
Why: The reason is the pipeline only needs to read from the bucket. Granting write permissions would allow a compromised pipeline to overwrite, corrupt, or delete build artifacts.

**III. Unrestricted iam:PassRole:**

Global iam:PassRole or passing arbitrary roles to any AWS service.
Why: When deploying a new ECS task definition, ECS requires iam:PassRole to attach execution and task roles to the containers.  Without strict resource constraints and a StringEquals condition limiting the pass-to service to ecs-tasks.amazonaws.com, a user with iam:PassRole could pass an administrative role to an ECS container and instantly escalate privileges to root level.

**IV. ECR Repository Creation/Deletion Permissions:**

Not given: Actions like ecr:CreateRepository or ecr:DeleteRepository.
Why: The reason is that Repositories should be provisioned via Infrastructure as Code (Terraform) ahead of time. The CI pipeline only needs to push images into an existing repository, not manage the lifecycle of the registry infrastructure.
