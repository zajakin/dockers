FROM debian:stable-slim
#FROM rocker/r-ver:3.5.0
#Use rocker from well maininted dockerhub as the parent image, will set up as a debian system
#debian:stretch

LABEL software.name="EnFusion"
LABEL software.version="EnFusion v1.0.0"
LABEL software.description="ensemble approach for fusion detection from RNA-seq data"
LABEL container.base.image="debian"
LABEL tags="Fusion Calling"

#Install necessary tools onto debian system  #Install necessary R packages used in overlap script  #Install tools using pip that will be used in the analysis
RUN apt-get update -y && apt-get install --no-install-recommends -y r-base make g++ libcurl4-openssl-dev vim less parallel python3-pip curl libpq-dev jq awscli python3-boto3 \
   && R -e "install.packages(c('devtools','optparse','VennDiagram','gridExtra','dplyr','readr','DBI','RPostgres','dbplyr','magrittr','purrr'), repos='http://cran.us.r-project.org/')"

COPY SCRIPTS /SCRIPTS
#ARG s3_folder=
# Run
ENTRYPOINT ["bin/bash",  "/SCRIPTS/kickoff_overlap.sh"]
#CMD [ "--output_location", "test_data" ]
