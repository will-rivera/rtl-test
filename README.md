# rtl-test
This repo hosts the RTL test code.

### Dependencies ###
* This assumes you have a service account created, with permsission to deploy to GKE, manage network resources, and read from GCR.
* You will need the following tools installed:
  * Terraform
  * helm
  * kubectl
  * gcloud

### The following errors were found in the helm chart ###
* API version of deployment.yaml was incorrect, changed to apps/v1, which makes it compatible with the latest version of K8S.
* values.yaml was missing an image path. Added the image path for the container uploaded to GCR.
* Changed the ClusterIP of the service to a NodePort. This ensures compatibility with the NGINX based ingress handler.
* Set the host to a resolvable public FQDN.
* changed liveness and readiness probe path.
* added a HostPort.

### Unfinished Tasks ###
1. Installation of istio: Since Istio apparently doesn't play as nicely with helm as it used to, I was looking for a way to install it without needing to run additional istioctl commands. But opted to set this aside since I didn't have a lot of time to dedicate to this test.
2. Install multiple environments: Didn't have time to dedicate to this step. I will however outline below what changes I would make for a multi-environment config.
3. Monitoring and Alerting: If more time were available, I would have setup alerting in stackdriver via the google_monitoring_alert_policy, at the very least using uptime checks, but also ideally using resource monitoring thresholds.
4. Private cluster: Started working on this, commented out the code as I didn't have time to finish it.

### Other Changes if Time Permitted ###
* If this were being deployed into a production environment, I'd seperate out the TF config into sub-directories for each environment.
  * Within each sub-directory would be tfvars to define environment specific variables.
  * I'd use the values directive of the helm_release module in helm.tf to pass down environment specific values to the helm config.
  * The CIDR range of the subnet created by terraform should also be mapped to the environment name.
* A Google Managed SSL cert should be generated and attached to the ingress. Weather using the NGINX ingress or a more advanced standalone ingress as detailed below.
* I'd prefer to completely rip out the Ingress and go with a Standalone Ingress to connect to Cloud LoadBalancer with more functionality. It would require that the LB is configured outside of Helm, but it would give more flexibility, and  access to features like CloudArmor. It's also a nice way to get around the resource creep that NGINX sometimes experiences. It takes more time to configure, but has its benefits.
