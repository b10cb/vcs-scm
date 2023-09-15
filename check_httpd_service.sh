#!/bin/bash

# Check if httpd service is running
if systemctl is-active --quiet httpd; then
    echo "httpd service is running."
else
    echo "httpd service is not running. Starting it now..."
    sudo systemctl start httpd
    echo "httpd service has been started."
fi
