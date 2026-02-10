FROM debian:testing-slim
# docker run -it debian:testing-slim bash
RUN apt update -y && apt dist-upgrade -y && apt install python3-pip mc sudo tmux -y && \
    pip install --break-system-packages humann --no-binary :all: && \
    pip install --break-system-packages numpy && \
    pip install --break-system-packages kraken-biom #&& \
    # pip install --break-system-packages qiime
CMD ["/usr/bin/bash"]
