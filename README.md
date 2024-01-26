# kubernetes-demo
A demo of a Kubernetes cluster fully setup and configured to show why Kubernetes is great 

## Deploy

Using Terraform Cloud:
- Create a workspace connected to this repository
- Connect the workspace with AWS via [Dynamic Credentials](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials/aws-configuration)
- Add a workspace environment variable `HETZNER_DNS_TOKEN` (required to configure NS records in Hetzner DNS)
- Trigger a new run in the workflow
