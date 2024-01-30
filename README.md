# kubernetes-demo
A demo of a Kubernetes cluster fully setup and configured to show why Kubernetes is great 

## Deploy

Using Terraform Cloud:
- Create a workspace connected to this repository (e.g VCS-driven workflow)
- Connect the workspace with AWS via [Dynamic Credentials](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials/aws-configuration)
- Trigger a new run in the workflow
- Put the NS records spilled out by Terraform into your DNS provider