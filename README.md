# Terrafrom - Docker
The readme and porject cover my first terraform things.

## What's What
### What's Terraform
Terraform is used to manage cloud and on-premises resources in a repeatable and automated manner, reducing manual setup and ensuring consistency across environments. It’s particularly useful for teams and organizations that want to maintain a scalable, consistent, and collaborative infrastructure management approach.

### What's the project
The project focuses on converting a local Docker deployment. Normally, we would deploy using a docker-compose.yml file and set up the network separately, but with Terraform, we're handling everything in a single file. This approach allows us to version-control our architecture with Git, and using variables makes tracking and updates much simpler.

Now, imagine we need to deploy this architecture to AWS Cloud. Without Terraform, we would need to manually create a lot of resources in the cloud. With Terraform, we can simplify and streamline the entire process.

## How to start
### Deploy git
```bash
git init
git add .
git commit -m "....."
```

### Deploy terraform
```bash
terraform init
```

**note**: just check your sutructure:
```bash
terraform plan
```

Deploy:
```bash
terraform apply
```



Resouce:
https://ruan.dev/blog/2021/11/23/run-docker-containers-with-terraform
