#!/bin/bash

date +"%m-%d-%y"
date +"%T"
apt-get update -y
apt-get full-upgrade -y
apt-get clean - y
apt-get autoclean -y
