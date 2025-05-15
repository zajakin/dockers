FROM ubuntu:jammy
#   docker run -it --rm --name test ubuntu:jammy bash
RUN env DEBIAN_FRONTEND=noninteractive apt-get update -y && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends dialog apt-utils curl gpg ca-certificates firefox x11vnc xvfb xauth && \
    curl -fsSL https://www.eparaksts.lv/files/ep3updates/debian/public.key | gpg --dearmor -o /usr/share/keyrings/eparaksts-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/eparaksts-keyring.gpg] https://www.eparaksts.lv/files/ep3updates/debian jammy eparaksts" > /etc/apt/sources.list.d/eparaksts.list && \
    env DEBIAN_FRONTEND=noninteractive apt-get update && \
    env DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends eparakstitajs3 awp latvia-eid-middleware eparaksts-token-signing
CMD ["/usr/bin/eparakstitajs3"]
#    mkdir -p /etc/xdg/autostart/ && \
# RUN echo "exec firefox" > ~/.xinitrc && chmod +x ~/.xinitrc
# xauth add ${xauth list | awk '{print $3; exit}'}
# CMD ["v11vnc", "-create", "-forever"]
# docker run --rm -ti --net=host -e DISPLAY=:0 -v /tmp/.X11-unix:/tmp/.X11-unix
