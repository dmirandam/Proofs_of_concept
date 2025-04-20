# secure exposition of on-premise k8s aplications using cloudflare tunnels and istio


🔐 **How can you securely expose internal on-prem services without opening public ports?**

This proof of concept explores a secure and manageable architecture for ingress into private infrastructure:

🧱 **Technical context:**
- K3s cluster running on 3 VMs managed by Proxmox (fully on-prem).
- No public IPs or open ports.
- Requirements: HTTPS access, secure ingress, path-based routing, and full control over certificates.

🧩 **Implemented solution:**
1. **Cloudflare Tunnel** enables encrypted access without needing a public IP.
2. A **`cloudflared` pod** inside the cluster receives traffic and forwards it to a local LoadBalancer IP.
3. **MetalLB** assigns internal IPs for services of type LoadBalancer.
4. **Istio Ingress Gateway** handles incoming traffic from the tunnel.
5. **Istio Gateway + VirtualServices** manage routing by host/path.
6. **TLS strict mode** enforced in Cloudflare; internal certs are managed via Istio.

⚙️ **Tunnel management:**
- Fully GitOps-friendly: the tunnel can be configured via YAML inside the `cloudflared` pod.
- Or optionally managed through the **Cloudflare Zero Trust dashboard**.

🛰️ High-level architecture diagram 👇


✅ **Result:**
- Secure HTTPS ingress without exposing any infrastructure.
- Fine-grained, declarative routing.
- Complete control over TLS, traffic flow, and tunnel configuration.


📌 This PoC shows it's possible to build a production-grade ingress layer for on-prem environments using open tools and zero public exposure.