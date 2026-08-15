# certificate-cert-manager

A Helm chart to create TLS certificates using cert-manager.  
Designed for GitOps workflows with ArgoCD and ApplicationSet integration.

---

## 📌 Features

- Creates `Certificate` resources for specified DNS names
- Supports ClusterIssuer or Issuer
- Parameterized via `values.yaml`
- Bitnami-style chart structure for reusability

---

## 🛠️ Configuration

You can override the default values using `override.yaml`. Example:

```yaml
name: my-cert
namespaceOverride: custom-ns

certificate:
  enabled: true
  secretName: "my-domain-tls"
  issuerRef:
    name: "letsencrypt-prod"
    kind: "ClusterIssuer"
  dnsNames:
    - "example.com"
    - "www.example.com"
  privateKey:
    algorithm: "ECDSA"
    size: 256
```