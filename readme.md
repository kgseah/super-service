# DevOps Interview Task

Thank you for taking the time to do our technical test. There are two parts to this:

## 1. Automated deployment 

We need to deploy a new .NET Core Web API application using a docker container.

Write code to do the following:

1. Run the automated tests
2. Package the application as a docker image
3. Deploy and run the image locally or in a public cloud

Improvements can also be made. For example:

- Make any changes to the application you think are useful for a deploy process
- Host the application in a secure fashion

The application is included under [`.\super-service`](`.\super-service`).

Your solution should be triggered by a powershell script called `Deploy.ps1`.

Under super-service folder run ./Deploy.ps1 or (mac) pwsh ./Deploy.ps1

# 2. Infrastructure

You are tasked with setting up a kubernetes cluster to host new web services. The web services will be providing a public API to an existing internal systems. The internal systems are hosted on a virtual network named "internal-assets", and it is imperative that a high level of security is maintained around this virtual network.
Please provide a brief description of the infrastructure you would put in place. You can describe your set up in words or pictures, but please ensure you account for the following constraints:

1. You have a choice of which hosting provider it is deployed with.
Choice of Cloud provider will be Azure and Azure Devops for CI/CD

2. Your cluster is going to host web services that need to be published on the internet.
Use Terraform to create Azure Kubernetes Service(AKS). Note that the vpc subnet should be in a different range to peer to internal-assest network. For application deployment, use helm install/upgrade with AKS ingress to auto provsison Application Load Balancer(ALB). Use AKS to generate a tls in secret. Add to ingress and once complete, add ALB endpoint to Azure DNS to map human understable url (example https://hello-app/time)

3. A support team will need to be notified if web services lose connectivity to the internal assets
Use Datadog to monitor the web service, in the event of service down will trigger a notification to Microsoft Team for the reverlant team to assis the support

4. Developers should be able to deploy code in an automated manner.
Use Azure Devops service to monitor the Source Code Management tool. In pipeline, add trigger on the branch whenever commit. After container image is build finish, push to Azure Container Registry.

5. The cluster will need to be able to access pre-existing internal systems on the "internal-assets" virtual network. Describe how we can access that securely.
Use of Azure Private Link or service endpoints to connect the ACK service. If is internal use, limit to only whitelist ip address to connect in network security group. Implement sso intergration together with office365, this only limit authorised user to get access api

You do not need to provide complete implementation details for the above, but please be specific about the selection of technologies you would use.

## Submitting

Create a Git repository which includes instructions on how to run the solution to part 1, and documentation for part 2.