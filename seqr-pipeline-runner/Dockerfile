FROM gcr.io/seqr-project/pipeline-runner:gcloud-prod
RUN apt update && apt upgrade -y && apt dist-upgrade -y && apt install -y libdbd-mysql-perl mc && gcloud components update --quiet && rm /usr/local/bin/gsutil && apt autoremove -y && apt clean -y
