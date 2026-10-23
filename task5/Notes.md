**Task5:**

. Fixed the bugs and placed the final code in the file 'fixed-and-final.tf' .

**Bug1:**
**Trust policy:** 

Since roleB is an IAM role, but the principal ARN incorrectly identifies it as an IAM user.
	arn:aws:iam::000000000000:**user**/roleB

It should be:
	arn:aws:iam::000000000000:**role**/roleB

**Bug2:**
**Permissions policy:**
	"Action": "s3:*" and "Resource": "\*"
This combination **grants all S3 actions against all S3 resources** that the policy applies to, rather than limiting access to the intended bucket. It violates least privilege and could allow access to unrelated buckets if no other policy or control prevents it.

I corrected the policy to use the ARN of the designated bucket for s3:ListBucket and the bucket's object ARN (bucket-name/\*) for object operations. This separates bucket-level permissions from object-level permissions and limits roleC's S3 access to the intended bucket.
