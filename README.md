### Important for Containers
1. When you use git clone, you need to change python volume path:
2. If you want to deploy postgres volume, you need to clean every `terragrunt apply`

### How to Run:
Example:
```bash
cd servers/dev

terragrunt init
terragrunt plan
terragrunt apply
terragrunt destroy
````