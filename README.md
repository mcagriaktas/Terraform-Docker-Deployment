### Important for Containers
1. When you use git clone, you need to change python volume path.
2. If you want to deploy the PostgreSQL volume, you need to clean the volume path when you use `terragrunt apply`.

**Tips**: You can add your volume path in the `module/docker/main.tf`

### How to Run:
Example:
```bash
cd servers/dev

terragrunt init
terragrunt plan
terragrunt apply
terragrunt destroy
````
