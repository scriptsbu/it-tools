#! /bin/bash
read -p "Enter Region (usa,str,mtl):" region
read -p "Enter Computer make (dell,lenovo):" brand
read -p "Enter Computer model (l5420,T14):" model
read -p "Enter Computer form factor(laptop,desktop):" form
sudo bash -c 'echo "tags = ${region},${brand},${model},${form}" >> /etc/landscape/client.conf'
