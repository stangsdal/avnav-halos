# Installation

## 1. Build the image

Run on the HaLOS host, from a checkout of this repository:

```sh
docker build -t avnav-halos:20251028 .
```

The build stops if the tested O-ChartsNG source line is absent. This avoids
silently producing an image with a partial patch.

## 2. Configure Compose

Copy compose/avnav-halos.yml into the Compose project used by HaLOS, or merge
its service labels into the existing AvNav service. Set the real DNS name in
the router rule and ensure the external network exists:

```sh
docker network inspect halos-proxy-network >/dev/null
```

If the existing service currently says:

```yaml
image: xfreex/avnav-stable:20251028
```

replace it with:

```yaml
image: avnav-halos:20251028
```

Then recreate only AvNav:

```sh
docker compose -f /path/to/compose.yml up -d --no-deps avnav
```

## 3. Verify

- Open AvNav through the HTTPS hostname.
- Confirm the browser URL is HTTPS.
- Open O-ChartsNG and verify registration uses port 4432.
- In browser developer tools, confirm the WebSocket is wss://, not ws://.
- Check the container logs:

```sh
docker logs --tail=100 avnav
```

## Rollback

Keep the previous image and Compose backup. Roll back with:

```sh
cp /path/to/docker-compose.yml.bak /path/to/docker-compose.yml
docker compose -f /path/to/docker-compose.yml up -d --no-deps avnav
```

If the old image was removed, restore it from the registry or rebuild the
original xfreex/avnav-stable:20251028 service definition.
