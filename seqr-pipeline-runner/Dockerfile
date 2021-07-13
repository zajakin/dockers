FROM gcr.io/seqr-project/pipeline-runner:gcloud-prod
RUN apt update \
	&& apt upgrade -y \
	&& apt dist-upgrade -y \
	&& apt install -y libxml-perl libdbd-mysql-perl mc iproute2 tmux \
	&& cpanm Bio::DB::HTS \
	&& gcloud components update --quiet \
	&& rm /usr/local/bin/gsutil \
	&& apt autoremove -y \
	&& apt clean -y \
	&& /usr/local/bin/python3 -m pip install --upgrade pip \
	&& pip install -U `pip list --outdated | awk 'NR>2 {print $1}'` \
	&& wget https://github.com/zajakin/dockers/raw/master/seqr-pipeline-runner/vep-GRCh37.json -O /vep-GRCh37.json \
	&& wget https://github.com/zajakin/dockers/raw/master/seqr-pipeline-runner/vep-GRCh38.json -O /vep-GRCh38.json
