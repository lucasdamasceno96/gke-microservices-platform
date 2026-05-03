# GKE Microservices Platform (Online Boutique)

A lean, professional deployment of Google's [Online Boutique](https://github.com/GoogleCloudPlatform/microservices-demo) microservices application on Google Kubernetes Engine (GKE).

## 🎯 Architecture Overview

- **Cloud Provider:** Google Cloud Platform (GCP)
- **Infrastructure as Code:** Terraform (State stored remotely in GCS)
- **Kubernetes:** GKE Autopilot (Cost-effective, zero node management)
- **CI/CD:** GitHub Actions (Direct deployment via `kubectl`/`helm`)
- **Security:** Workload Identity Federation (Keyless authentication)

## 🚀 Deployment Pipeline

1.  **Terraform:** Provisions VPC, Subnets, and the GKE Autopilot cluster.
2.  **GitHub Actions:** Authenticates to GCP via Workload Identity and deploys the application manifests.

## 🏗️ Architecture at a Glance

flowchart TB
%% Users
U[User / Browser]

    %% GCP
    subgraph GCP[Google Cloud Platform]

        %% Networking / Entry
        LB[Load Balancer / Ingress]

        %% GKE Cluster
        subgraph GKE[GKE Autopilot Cluster]

            %% Microservices
            FE[Frontend Service]
            PS[Product Catalog Service]
            CT[Cart Service]
            CO[Checkout Service]
            PY[Payment Service]
            SH[Shipping Service]
            RE[Recommendation Service]
            EM[Email Service]
            CU[Currency Service]
            AD[Ad Service]

        end

        %% State / Infra
        TF[Terraform]
        GCS[GCS Bucket (Terraform State)]

    end

    %% CI/CD
    subgraph CICD[CI/CD Pipeline]
        GH[GitHub Repository]
        GA[GitHub Actions]
    end

    %% Auth
    WI[Workload Identity Federation]

    %% Flow
    U --> LB
    LB --> FE

    FE --> PS
    FE --> CT
    FE --> RE
    FE --> AD

    CT --> CO
    CO --> PY
    CO --> SH
    CO --> EM
    CO --> CU

    %% CI/CD Flow
    GH --> GA
    GA --> WI
    WI --> GKE

    %% Terraform Flow
    TF --> GCS
    TF --> GKE
