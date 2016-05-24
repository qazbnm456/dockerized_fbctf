#!/usr/bin/env bash

########################################################
# This is the main config file for letsencrypt.sh      #
#                                                      #
# This file is looked for in the following locations:  #
# $SCRIPTDIR/config.sh (next to this script)           #
# /usr/local/etc/letsencrypt.sh/config.sh              #
# /etc/letsencrypt.sh/config.sh                        #
# ${PWD}/config.sh (in current working-directory)      #
#                                                      #
# Default values of this config are in comments        #
########################################################

# Which challenge should be used? Currently http-01 and dns-01 are supported
CHALLENGETYPE="http-01"

# Output directory for challenge-tokens to be served by webserver or deployed in HOOK (default: $BASEDIR/.acme-challenges)
WELLKNOWN="/var/www/fbctf/src/.well-known/acme-challenge"

# Which public key algorithm should be used? Supported: rsa, prime256v1 and secp384r1
KEY_ALGO=rsa
