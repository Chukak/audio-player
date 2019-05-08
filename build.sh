#!/bin/bash

if [[ $# > 0 ]]; then
    dotnet publish -c Release -r $1
    cp -r qml/ ./bin/Release/netcoreapp2.2/$1/
    cp -r js/ ./bin/Release/netcoreapp2.2/$1/
    cp -r icons/ ./bin/Release/netcoreapp2.2/$1
else 
    echo "Arguments: ubuntu.18.04-x64; ubuntu.16.04-x64; etc..."
    exit 128
fi



            
