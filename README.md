# AvNav on HaLOS

A reproducible AvNav image for HaLOS, based on
xfreex/avnav-stable:20251028.

The project addresses the tested O-ChartsNG registration issue:

- O-ChartsNG registration is changed from the hard-coded HTTP URL to
  https://$HOST:4432/static/%s.
- Traefik terminates HTTPS and routes app-4432 to container port 8083.
- AvNav WebSocket traffic is expected to use wss:// when the UI is served
  over HTTPS.
- The patch installer fails closed if the expected AvNav source is not found.

## Files

- Dockerfile: builds avnav-halos:20251028.
- compose/avnav-halos.yml: complete Compose/Traefik example.
- compose/traefik-labels.yml: labels for an existing service.
- patches/: O-ChartsNG patch and safe WebSocket guidance.
- docs/INSTALL.md: installation, verification and rollback.
- docs/TEST-MATRIX.md: tested baseline and upgrade checks.

## Quick start

```sh
docker build -t avnav-halos:20251028 .
docker compose -f compose/avnav-halos.yml up -d
```

Replace avnav.example.invalid with the real HTTPS hostname before starting.
