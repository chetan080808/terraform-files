Over the past few days of hands-on Terraform on AWS, these are the problems encountered and the exact fixes that worked.

1. Local module path error: Terraform threw “Unreadable module directory” because the module source path was mis-referenced and included spaces; fixed by pointing source to the correct relative folder (e.g., ./infra-app) and avoiding spaces in directory names.​

2. Conditional type bug: Wrote t2.small/t2.micro without quotes, causing “Reference to undeclared resource”; fixed by using strings in the ternary: instance_type = var.env == "prod" ? "t2.small" : "t2.micro", with a validation on env.​

3. VPC/subnet vs SG mismatch: EC2 launch failed with “SG and subnet belong to different VPCs”; resolved by explicitly setting subnet_id to the custom VPC subnet used by the SG and correcting tag key capitalization to Name/Description.​

4. Safe imports and drift: After importing an existing EC2, plan showed “~” updates (tags) not destroy; learned to look for “-/+” and “forces replacement” markers and to use lifecycle ignore_changes for non-critical diffs.​

5. Importing AWS Key Pair: Import failed using Key Pair ID (key-xxxx) instead of the Name; solved by importing with the key name and ensuring correct region; noted AWS doesn’t return public_key, so config/state needs alignment to avoid replacement.​

Apply partial failures: Noted that failed applies can still create resources; used targeted destroy or manual cleanup, and adopted the workflow “write config → import → verify plan → then change” instead of apply-first.​

Remote state best practice: Moved to S3 backend with DynamoDB locking to avoid losing local state and to enable team-safe workflows.​

Key takeaways: quote strings in conditionals, always align VPC-subnet-SG, import with correct identifiers, quote for_each addresses in the shell, prefer remote state, and read the plan symbols carefully (~ vs -/+). A mini-series with code snippets is coming next.
