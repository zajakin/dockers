FROM debian:stable-slim
RUN apt update && apt install -y --no-install-recommends nethogs && apt autoremove -y && apt clean -y && rm -rf /var/lib/apt/lists/*
STOPSIGNAL SIGQUIT
CMD ["/usr/sbin/nethogs"]
