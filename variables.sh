#!/bin/bash
# Configuration for creation of the ISO image. This script is executed by
# create-iso.sh

set -x   # Print each command before executing it
set -e   # Exit immediately should a command fail
set -u   # Treat unset variables as an error and exit immediately

export RELEASE=0.4.1   # Release version number
export DATE=20180311   # Timestamp to use for version packages (`date +%Y%m%d`)
export DIST=stretch    # Debian distribution to base image on
export ARCH=amd64      # Target architecture
export SHASUM="75655fe0fef0733e8bf51cc9badb6592ebb84f232a2a60efcfde9ea78b510568  -" # ISO image SHA-256
export SOURCE_DATE_EPOCH="$(date --utc --date="$DATE" +%s)" # defined by reproducible-builds.org
export WD=/opt/coen-${RELEASE}	       # Working directory to create the image
export ISONAME=${WD}-${ARCH}.iso       # Final name of the ISO image
export TOOL_DIR=/tools                 # Location to install the tools
export HOOK_DIR=$TOOL_DIR/hooks        # Hooks
export PACKAGE_DIR=$TOOL_DIR/packages  # Packages
