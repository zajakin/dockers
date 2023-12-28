# Dockers

### Generation of multiple Docker containers.

To install enter this command in your terminal on server:

    docker run --rm -v $(pwd):/mnt ghcr.io/zajakin/mmex find -maxdepth 1 -name mmex*.deb -exec cp {} /mnt/ \; && docker rmi ghcr.io/zajakin/mmex

Containers:

 * MMEx
 * 
 
Screenshot:

 ![](https://github.com/zajakin/dockers/preview.png "Screenshot")

