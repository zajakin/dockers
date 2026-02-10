FROM debian:testing-slim
# docker run -it debian:testing-slim bash
RUN apt update -y && apt dist-upgrade -y && apt install python3-pip mc sudo tmux pigz metaphlan bowtie2 diamond-aligner python3-biom-format samtools -y && \
    pip install --break-system-packages humann --no-binary :all: && \
    chmod 666 `find /usr/local/lib/  -name  humann.cfg` && \
    pip install --break-system-packages numpy && \
    pip install --break-system-packages kraken-biom && \
    useradd -ms /bin/bash humann
#USER humann
CMD ["/usr/bin/bash"]
