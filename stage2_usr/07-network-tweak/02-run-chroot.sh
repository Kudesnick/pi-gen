#!/bin/bash -e

systemctl start NetworkManager.service 
systemctl enable NetworkManager.service
