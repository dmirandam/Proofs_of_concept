# Securely Exposing On-Prem Kubernetes Services Without Public Ports – A Production-Grade PoC

### This proof of concept presents a robust ingress architecture for exposing internal services running in an on-premise Kubernetes cluster, with **zero reliance on public IPs or open ports**, and full TLS enforcement.

## Architecture context:
- Kubernetes distribution: **K3s** deployed across 3 VMs on **Proxmox**.
- Services must be reachable externally via HTTPS.
- The environment is fully **on-premise**, with **no public cloud dependencies**.
- Strong preference for **GitOps-compatible**, declarative infrastructure.

## Solution overview:
1. **Cloudflare Tunnel** is used as the secure entry point. No ports are exposed to the public internet.
2. A dedicated **`cloudflared` pod** within the cluster handles inbound tunnel traffic.
3. **MetalLB** provides internal LoadBalancer IPs to expose cluster services.
4. **Istio Ingress Gateway** receives traffic and delegates to VirtualServices.
5. **Istio Gateway + VirtualService resources** manage routing based on host/path.
6. TLS is fully enforced using **Cloudflare’s “Full (Strict)” mode** with internal certificates.

## Tunnel management:
- Configured via a `config.yml` inside the `cloudflared` pod – ideal for **GitOps workflows**.
- Alternatively, tunnel behavior can be managed via the **Cloudflare Zero Trust Dashboard**.

## Key results:
- No public IPs or exposed ports.
- Full TLS encryption from client to workload.
- Fine-grained traffic control with Istio.
- Entire setup defined as code, reproducible, and maintainable.

### This setup demonstrates a **secure, declarative, and production-grade ingress model** for Kubernetes clusters in private infrastructure environments.

## Architecture diagram
<img src="https://dmirandam-public-images.s3.us-east-1.amazonaws.com/secure_exposition_using_cloudflare_tunnels_and_istio.png" alt="Architecture Diagram" width="5000"/>