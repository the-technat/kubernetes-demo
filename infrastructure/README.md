# Infrastructure

This is the module that deploys the cluster including all it's addons.

## Design Decisions

- Everything is deployed using Terraform
- Dependencies shall be strict and clear, except:
  - Metrics (as there you can add annotations beforehand)
  - Ingress resources (as there you can create the actual resources beforehand)

<!-- BEGIN_TF_DOCS -->


<!-- END_TF_DOCS -->