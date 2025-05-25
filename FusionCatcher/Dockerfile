FROM debian:buster-slim
# docker run -it debian:buster-slim bash
RUN apt update && apt dist-upgrade -y --no-install-recommends && apt install -y --no-install-recommends wget gawk gcc g++ make cmake automake curl unzip zip bzip2 tar gzip pigz parallel build-essential libncurses5-dev libc6-dev zlib1g zlib1g-dev libtbb-dev libtbb2 ca-certificates-java \
    && apt install -y --no-install-recommends python python-dev python-numpy python-biopython python-xlrd python-openpyxl default-jdk \
    && wget http://sf.net/projects/fusioncatcher/files/bootstrap.py -O bootstrap.py \
    && python bootstrap.py -t -y \
    && mv /opt/fusioncatcher/data /opt/fusioncatcher/data.orig \
    && apt autoremove -y && apt clean -y && rm -rf /var/lib/apt/lists/*
STOPSIGNAL SIGQUIT
CMD ["/usr/sbin/nethogs"]
# docker run --rm -v /data/db/fusioncatcher:/opt/fusioncatcher/data ghcr.io/zajakin/fusioncatcher bash -c "cp /opt/fusioncatcher/data.orig/download-human-db.sh /opt/fusioncatcher/data/download-human-db.sh && cd /opt/fusioncatcher/data/ && ./download-human-db.sh"
