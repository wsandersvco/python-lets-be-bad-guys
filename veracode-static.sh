#!/bin/bash

# Veracode Static Analysis (SAST) Script for verademo.war
# This script triggers a Veracode Static Policy Scan using the Veracode CLI

set -e

echo "Starting Veracode Static Analysis (SAST) Scan..."

# Check if Veracode API credentials are set
# if [ -z "$VERACODE_API_KEY_ID" ] || [ -z "$VERACODE_API_KEY_SECRET" ]; then
#     echo "Error: VERACODE_API_KEY_ID and VERACODE_API_KEY_SECRET environment variables must be set"
#     exit 1
# fi

# Define the WAR file location
ZIP_FILE="python-lets-be-bad-guys.zip"

# Check if the WAR file exists
if [ ! -f "$ZIP_FILE" ]; then
    echo "Error: $ZIP_FILE not found. Please build the project first."
    echo "Run: zip -r python-lets-be-bad-guys.zip manage.py badguys"
    exit 1
fi

echo "Found WAR file: $ZIP_FILE"

# Check if Veracode CLI is installed
if ! command -v veracode &> /dev/null; then
    echo "Error: Veracode CLI is not installed."
    echo "Or visit: https://docs.veracode.com/r/Veracode_CLI"
    exit 1
fi

echo "Veracode CLI found: $(veracode version)"

# Application name
APP_NAME="python-lets-be-bad-guys"
APP_ID="2904038"

# Run static analysis scan
echo "Uploading and scanning $ZIP_FILE..."
echo "Application: $APP_NAME"

veracode static scan \
    "$ZIP_FILE" \
    --app-id "$APP_ID"

SCAN_EXIT_CODE=$?

echo ""
echo "Static Analysis scan completed with exit code: $SCAN_EXIT_CODE"

exit $SCAN_EXIT_CODE
