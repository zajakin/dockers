FROM debian:testing-slim
RUN apt-get update -y && apt-get install -y --no-install-recommends wget
RUN wget https://github.com/zajakin/dockers/raw/master/mmex/make_mmex.sh && \
    chmod +x make_mmex.sh #&& \
#    /usr/bin/bash -c ./make_mmex.sh
CMD ["/usr/bin/bash"]
