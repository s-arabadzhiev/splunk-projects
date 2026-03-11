#!/bin/bash

# --- CONFIGURATION ---
# Detect existing installation or set default
if [ -d "/opt/splunk" ]; then
    SPLUNK_HOME="/opt/splunk"
elif [ -d "/opt/splunkforwarder" ]; then
    SPLUNK_HOME="/opt/splunkforwarder"
else
    SPLUNK_HOME=""
fi

echo "==========================================================="
echo "   Splunk Project Automated Deployment"
echo "==========================================================="

# 1. Check for Splunk installation
if [ -z "$SPLUNK_HOME" ]; then
    echo "[-] Splunk not found. Starting fresh installation..."
    # calling splunk installation script
    sudo ./scripts/splunk_install.sh
    SPLUNK_HOME="/opt/splunk" # restart after install
else
    echo "[+] Found Splunk at $SPLUNK_HOME"
fi

# 2. Stop Splunk for safe configuration (Cold Deploy)
echo "[>] Stopping Splunk to apply configurations..."
sudo $SPLUNK_HOME/bin/splunk stop

# 3. Copy configurations
echo "[>] Deploying custom configurations..."

# Apps
if [ -d "./configs/apps" ]; then
    sudo cp -r ./configs/apps/* $SPLUNK_HOME/etc/apps/
    echo "    -> Custom Apps deployed."
fi

# System Local
if [ -d "./configs/system/local" ]; then
    sudo cp -r ./configs/system/local/* $SPLUNK_HOME/etc/system/local/
    echo "    -> System local configurations deployed."
fi

# Deployment Apps (ако е Deployment Server)
if [ -d "./configs/deployment-apps" ] && [ "$SPLUNK_HOME" == "/opt/splunk" ]; then
    sudo mkdir -p $SPLUNK_HOME/etc/deployment-apps
    sudo cp -r ./configs/deployment-apps/* $SPLUNK_HOME/etc/deployment-apps/
    echo "    -> Deployment Apps deployed."
fi

# 4. Set ownership (Owner: splunk)
echo "[>] Fixing file permissions..."
sudo chown -R splunk:splunk $SPLUNK_HOME

# 5. Start
echo "[>] Starting Splunk..."
sudo $SPLUNK_HOME/bin/splunk start --accept-license --answer-yes --no-prompt

echo "==========================================================="
echo "✅ Project Deployed and Running!"
echo "==========================================================="
