FROM debian:slim
RUN apt update && apt install nethogs -y
STOPSIGNAL SIGQUIT
CMD ["/usr/sbin/nethogs"]
