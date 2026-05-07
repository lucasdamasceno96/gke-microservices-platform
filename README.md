<div align="center">
  <img src="./assets/k8s-master.jpg" alt="K8s Master Concept" width="400" style="border-radius: 15px;"/>

  <h1>🚀 GKE Microservices Platform (Online Boutique)</h1>

  <p><i>A lean, professional, and secure deployment of Google's 11-tier microservices application on Kubernetes.</i></p>

  <!-- Badges -->
  <img src="https://img.shields.io/badge/GoogleCloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white" />
  <img src="https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white" />
  <img src="https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white" />
  <img src="https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white" />
</div>

<h2> 🎯 Mission </h2>

A **lean, production-style Kubernetes platform** built to prove that the basics are enough when done right.

Ship fast, keep it simple, and operate with confidence.

* No ClickOps
* No static credentials
* No node management
* No manual deployments

Only infrastructure as code, secure automation, GitOps workflows, and GKE Autopilot.

This project shows how Platform Engineering principles can reduce complexity while still supporting a real 11-microservice system with security, scalability, and cost efficiency built in from day one.

## 🏗️ Architecture at a Glance

<div align="center">
  <img src="./assets/full-arch.jpg" alt="Architecture Diagram" width="800" />
</div>

<br>

- **☁️ Cloud Provider:** Google Cloud Platform (GCP)
- **🧱 Infrastructure as Code:** Terraform (State stored remotely and securely in a GCS bucket)
- **☸️ Kubernetes:** GKE Autopilot (Cost-effective, zero node management, pay-per-pod)
- **🤖 CI/CD:** GitHub Actions (Direct deployment via `kubectl`)
- **🛡️ Security:** Workload Identity Federation (Keyless authentication - OIDC)

---

## 🚀 The Pipeline (GitOps Flow)

This repository is fully automated. Merging to `main` triggers the following lifecycle:

1. **🔐 Auth:** GitHub Actions exchanges its OIDC token for a temporary GCP access token via Workload Identity.
2. **🏗️ Provisioning:** `terraform plan` and `terraform apply` ensure the VPC, Subnets, and GKE cluster are in the desired state.
3. **🚢 Deployment:** The pipeline connects to GKE and applies the Kubernetes manifests for all 11 microservices (Frontend, Cart, Redis, Checkout, etc.) in the `online-boutique` namespace.
4. **✅ Health Check:** `kubectl rollout status` waits for the frontend to be fully available before marking the pipeline as successful.

---

## 📸 Mission Accomplished (The Proof)

Here is the infrastructure running successfully in production:

### 1. Terraform & GitHub Actions in perfect sync

<img src="./assets/gke1.jpg" alt="GitHub Actions Pipeline Success" width="800" />

### 2. The 11 Microservices alive on GKE

<img src="./assets/gke2.jpg" alt="Kubernetes Pods Running" width="800" />

---

## 🧹 Cost Optimization (Teardown)

To keep the cloud bill lean after the demonstration, the entire environment can be destroyed safely:

```bash
terraform destroy -var="project_id=YOUR_PROJECT_ID"
```
