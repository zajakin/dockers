n S
mkdir ~/CLCNetworkLicenseManager5
pushd ~/CLCNetworkLicenseManager5
docker run -it --name="CLCNetworkLicenseManager5_pre" debian:stable-slim
apt-get update && apt-get install -y --no-install-recommends libfreetype6 wget ca-certificates && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*
useradd -m clclicsrv
wget https://download.clcbio.com/clclicsrv/5.0/CLCNetworkLicenseManager_5_0_64.sh -O CLCNetworkLicenseManager_5.sh
bash CLCNetworkLicenseManager_5.sh

1
/opt/CLCNetworkLicenseManager5
rm CLCNetworkLicenseManager_5.sh
chown -R clclicsrv /opt/CLCNetworkLicenseManager5
exit
docker commit CLCNetworkLicenseManager5_pre clc_network_license_manager5
docker rm CLCNetworkLicenseManager5_pre


docker images
touch ./licenseserver.log
chmod 666 licenseserver.log
docker run -d --name="CLCNetworkLicenseManager5" -t -u clclicsrv -p 6200:6200 -v `pwd`/licenseserver.log:/opt/CLCNetworkLicenseManager5/licenseserver.log -v `pwd`/licenses:/opt/CLCNetworkLicenseManager5/licenses --restart always clc_network_license_manager5 /opt/CLCNetworkLicenseManager5/runscript/clclicsrv start 
docker ps -lsa
docker logs CLCNetworkLicenseManager5
docker top CLCNetworkLicenseManager5
docker exec -it CLCNetworkLicenseManager5 /opt/CLCNetworkLicenseManager5/downloadlicense
popd

docker stop CLCNetworkLicenseManager5
docker rm CLCNetworkLicenseManager5
docker rmi clc_network_license_manager5
docker images
