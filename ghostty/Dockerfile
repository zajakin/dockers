FROM debian:testing-slim
# docker run -it debian:testing-slim bash
RUN apt-get update -y && apt-get install -y --no-install-recommends curl ca-certificates && \
    curl -fsSL -O https://github.com/zajakin/dockers/raw/master/ghostty/make.sh && \
    chmod +x make_mmex.sh && \
    /usr/bin/bash -c ./make_mmex.sh
CMD ["/usr/bin/bash"]
