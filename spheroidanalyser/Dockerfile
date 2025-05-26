FROM rocker/shiny
# FROM debian:testing-slim
# docker run --rm --name SpheroidAnalyseR -p 3838:3838 -d -v $(pwd):/mnt -e R_LIBS=/usr/local/lib/R/site-library:/usr/local/lib/R/library:/usr/lib/R/site-library:/usr/lib/R/library -e R_LIBS_SITE=/usr/local/lib/R/site-library:/usr/lib/R/site-library ghcr.io/zajakin/spheroidanalyser
# docker run -it rocker/shiny bash    # ; remotes::install_github('GliomaGenomics/SpheroidAnalyseR')
#RUN apt-get update && apt-get install --no-install-recommends r-base-dev git -y \
#	&& R -e "options(repos = c(CRAN = 'http://cran.rstudio.com')); install.packages('BiocManager'); BiocManager::install(c('tidyverse','ggthemes','gridExtra','readxl','openxlsx','plotrix','writexl','ggpubr','shiny','shinyjs','DT'))" \
# r-cran-shiny
RUN apt-get update && apt-get install --no-install-recommends r-base-dev git r-cran-biocmanager r-cran-tidyverse r-cran-ggthemes r-cran-gridextra  r-cran-readxl r-cran-openxlsx r-cran-plotrix r-cran-writexl r-cran-ggpubr r-cran-dt r-cran-shinyjs -y \
	&& apt autoremove -y \
	&& apt clean -y \
	&& git clone --recursive https://github.com/GliomaGenomics/SpheroidAnalyseR.git \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /srv/shiny-server \
	&& ln -s /SpheroidAnalyseR /srv/shiny-server
#COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf
#COPY shiny-server.sh /usr/bin/shiny-server.sh
#EXPOSE 80
STOPSIGNAL SIGQUIT
#CMD ["/usr/bin/shiny-server.sh"]
