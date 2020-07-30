#!/bin/bash

DEBIAN_FRONTEND=noninteractive

date +"%m-%d-%y"
date +"%T"
apt-get update -y -qq
apt-get full-upgrade -y -qq
apt-get clean - y -qq
apt-get autoclean -y -qq
