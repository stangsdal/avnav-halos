FROM xfreex/avnav-stable:20251028

LABEL org.opencontainers.image.title="AvNav HaLOS HTTPS"
LABEL org.opencontainers.image.description="AvNav with the O-ChartsNG HTTPS registration patch"

COPY patches/ochartsng-https.patch /tmp/ochartsng-https.patch
COPY scripts/apply-patches.sh /usr/local/sbin/apply-avnav-halos-patches

RUN chmod 0755 /usr/local/sbin/apply-avnav-halos-patches \
    && /usr/local/sbin/apply-avnav-halos-patches \
    && rm -f /tmp/ochartsng-https.patch

EXPOSE 8080 8083
