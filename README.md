#1 challenge


Azure resources used:
Resource group
Network and subnets
App service-web app
SQL MAnaged instance
App service- Web app

there is on main.tf file with all the base infra and workload code.
variables will be substituted using .tfvars of each resource
pipeline.yaml will be used to configure the pipeline and set variables like build agents, tasks and steps
