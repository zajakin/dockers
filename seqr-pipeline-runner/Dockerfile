FROM gcr.io/seqr-project/pipeline-runner:gcloud-prod
RUN apt update && apt upgrade -y && apt dist-upgrade -y && apt install -y libdbd-mysql-perl mc && gcloud components update --quiet && rm /usr/local/bin/gsutil && apt autoremove -y && apt clean -y
RUN /usr/local/bin/python3 -m pip install --upgrade pip && pip install -U `pip list --outdated | awk 'NR>2 {print $1}'` && apt install -y iproute2