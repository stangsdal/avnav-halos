# Test matrix

The project is based on the observed combination:

- base image: xfreex/avnav-stable:20251028
- AvNav: 20250822
- O-ChartsNG: 20260703
- tested O-ChartsNG source: /usr/lib/avnav/plugins/ochartsng/plugin.py
- Traefik HTTPS router: app-4432 -> 8083
- Docker network label: traefik.docker.network=halos-proxy-network

Before deploying a newer base image, repeat:

1. image build;
2. O-ChartsNG registration from the HTTPS hostname;
3. AvNav WebSocket connection over wss://;
4. chart display and a normal AvNav restart;
5. rollback to the original image.
