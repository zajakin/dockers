git clone https://github.com/nch-igm/EnFusion.git
cd EnFusion
docker build . -t enfusion
docker run enfusion -h
