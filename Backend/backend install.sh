#!/bin/bash
#De microsoft libraries worden toegevoegd
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
#De mssql repo wordt toegevoegd
sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2022.list)"
#De libraries worden bijgewerkt
sudo apt-get update
sudo apt-get upgrade
#De dotnet 6.0 packages worden geïnstalleerd
sudo apt-get install -y dotnet-sdk-6.0
curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
#De mssql package wordt geïnstalleerd
sudo apt-get install -y mssql-server
#Ms sql wordt geconfigureerd
sudo /opt/mssql/bin/mssql-conf setup
systemctl status mssql-server --no-pager
sudo apt install git
git clone https://github.com/Microsoft/Bing-Maps-Fleet-Tracker/
dotnet build Backend/
dotnet build Backend/src/Trackable.Web/
dotnet run --project Backend/src/Trackable.Web/Trackable.Web.csproj
