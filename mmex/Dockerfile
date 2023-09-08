FROM debian:testing-slim
RUN wget --no-cache https://github.com/zajakin/dockers/raw/master/mmex/make_mmex.sh -O make_mmex.sh && \
    chmod +x make_mmex.sh && \
    /usr/bin/bash -c ./make_mmex.sh
CMD ["/usr/bin/bash"]
