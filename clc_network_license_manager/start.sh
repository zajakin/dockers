n S
secret=`cat ~/.ssh/CLC/secret | grep -v ^#`

mkdir ~/CLCNetworkLicenseManager5
pushd ~/CLCNetworkLicenseManager5
docker pull debian:stable-slim
docker run -it --name="CLCNetworkLicenseManager5_pre" -v `pwd`/download:/download debian:stable-slim
apt-get update && apt-get install -y --no-install-recommends libfreetype6 wget ca-certificates tmux mc iproute2 && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*
useradd -m clclicsrv
# wget https://download.clcbio.com/clclicsrv/5.1/CLCNetworkLicenseManager_5_1_64.sh -O /download/CLCNetworkLicenseManager_5.sh
# wget https://download.clcbio.com/clclicsrv/5.0/CLCNetworkLicenseManager_5_0_64.sh -O /download/CLCNetworkLicenseManager_5.sh
bash /download/CLCNetworkLicenseManager_5.sh

1
/opt/CLCNetworkLicenseManager5
# rm CLCNetworkLicenseManager_5.sh
# sed -i 's/su - $USER/bash/' /opt/CLCNetworkLicenseManager5/runscript/clclicsrv
chown -R clclicsrv /opt/CLCNetworkLicenseManager5
tee /start.sh << END
#!/bin/bash
/opt/CLCNetworkLicenseManager5/lmx-serv-clcbio -b -c /opt/CLCNetworkLicenseManager5/licenseserver.cfg -l /opt/CLCNetworkLicenseManager5/licenses/ -lf /opt/CLCNetworkLicenseManager5/licenseserver.log -port 6200 && exit
END
chmod 777 /start.sh
exit
docker commit CLCNetworkLicenseManager5_pre clc_network_license_manager5
docker rm CLCNetworkLicenseManager5_pre


docker images
touch ./licenseserver.log
chmod 666 licenseserver.log
docker run -d --name="CLCNetworkLicenseManager5" $secret -u clclicsrv -p 6200:6200 -p 6200:6200/udp -v `pwd`/licenseserver.log:/opt/CLCNetworkLicenseManager5/licenseserver.log -v `pwd`/licenses:/opt/CLCNetworkLicenseManager5/licenses --restart always clc_network_license_manager5 tail -f /dev/null
docker exec -u clclicsrv CLCNetworkLicenseManager5 /start.sh

docker ps -lsa
docker logs CLCNetworkLicenseManager5
docker top CLCNetworkLicenseManager5
popd

# docker exec -it -u root CLCNetworkLicenseManager5 bash
# /opt/CLCNetworkLicenseManager5/lmxendutil -hostid
# /opt/CLCNetworkLicenseManager5/downloadlicense
# cat /opt/CLCNetworkLicenseManager5/licenseserver.log
 
# docker stop CLCNetworkLicenseManager5
# docker rm CLCNetworkLicenseManager5
# docker rmi clc_network_license_manager5
docker images
