FROM debian:testing-slim
# docker run -it rocker/shiny bash    # ; remotes::install_github('GliomaGenomics/SpheroidAnalyseR')
RUN apt-get update && apt-get install --no-install-recommends r-base-dev git -y \
	&& R -e "options(repos = c(CRAN = 'http://cran.rstudio.com')); install.packages('BiocManager'); 
	BiocManager::install(c('tidyverse','ggthemes','gridExtra','readxl','openxlsx','plotrix','writexl','ggpubr','shiny','shinyjs','DT'))" \
	&& apt autoremove -y \
	&& apt clean -y \
	&& git clone --recursive https://github.com/GliomaGenomics/SpheroidAnalyseR.git \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /srv/shiny-server \
	&& ln -s /SpheroidAnalyseR /srv/shiny-server
COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf
COPY shiny-server.sh /usr/bin/shiny-server.sh
EXPOSE 80
STOPSIGNAL SIGQUIT
CMD ["/usr/bin/shiny-server.sh"]
