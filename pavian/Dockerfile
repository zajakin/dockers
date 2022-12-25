FROM rocker/shiny
RUN apt-get update && apt-get install --no-install-recommends r-base-dev -y \
	&& R -e "options(repos = c(CRAN = 'http://cran.rstudio.com')); install.packages(c('remotes')); install.packages('BiocManager'); BiocManager::install('Rsamtools'); remotes::install_github('fbreitwieser/pavian')" \
	&& apt autoremove -y \
	&& apt clean -y \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /srv/shiny-server/*
COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf
COPY shiny-server.sh /usr/bin/shiny-server.sh
RUN R -e "sapply(list.files(system.file('shinyapp',package='pavian'),full.names=TRUE),file.copy,to='/srv/shiny-server/',recursive=TRUE)"
EXPOSE 80
STOPSIGNAL SIGQUIT
CMD ["/usr/bin/shiny-server.sh"]
#CMD ["/usr/sbin/R    pavian::runApp(port=5000)"]
