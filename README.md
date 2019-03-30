# audio-player

To install dotnet in Linux (Ubuntu 18.04)
```bash
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo add-apt-repository universe
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install dotnet-sdk-2.2
```

To install Qml.Net:
```bash
dotnet add package Qml.Net
dotnet add package Qml.Net.LinuxBinaries
```

Vieocard driver: <strong>Nvidia-390</strong> 

To install Taglib package:
```bash
dotnet add package taglib --version 2.1.0	
```
