**Task3:**

. You can mention the details of account-a & account-b user id and their profiles in the terraform.tfvars file.

. Created the user's 'micky' & 'john' , you can change their users in terraform.tfvars file along with the given 'engineer' and 'ci' users.

. Created the s3 bucket with the name 'arrise-assignment-task3-account-b'

1. **Would you actually give engine and ci IAM users with access keys in a real production setup, or would you do something different? Explain.**
No, in a modern production environment, creating long-lived IAM user access keys for automated workloads or CI/CD pipelines (engine and ci) causes significant security risks, such as accidental credential leakage (e.g., committed to GitHub) and the operational overhead of manual key rotation.

Instead, a secure architecture would utilize federated temporary credentials or native platform integrations:
For CI/CD (like GitHub Actions or GitLab CI): Use OpenID Connect (OIDC) federation. The CI/CD platform authenticates directly with AWS IAM via short-lived tokens without storing any static credentials.

For workloads running on AWS (EC2, ECS, EKS): Attach IAM Instance Profiles, ECS Task Roles, or EKS Pod Identities directly to the compute resources.
For programmatic/external integrations: Use AWS IAM Identity Center (formerly AWS SSO) with temporary session credentials or programmatic assume-role mechanisms.


2. **In roleC's trust policy, why does it matter whether you trust the whole Account A root vs. roleB's specific ARN?**
  Trusting the entire Account A root (arn:aws:iam::000000000000:root) delegates trust to any principal inside Account A. This means any user, role, or service in Account A that has been granted local sts:AssumeRole permissions could potentially assume roleC.

Trusting arn:aws:iam::000000000000:role/roleB explicitly enforces the Principle of Least Privilege:

It ensures that only roleB can cross account boundaries to access Account B's S3 bucket.
Prevents Lateral Movement: If another user or group or less-privileged role in Account A is compromised, the attacker cannot leverage that compromise to assume roleC and access Account B's data, because roleC's trust policy strictly rejects any principal other than roleB.
