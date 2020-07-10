#!/bin/bash
sudo systemctl stop networking
wait
sudo rmmod brcmfmac
wait
sudo modprobe brcmfmac
wait
sudo systemctl start networking


