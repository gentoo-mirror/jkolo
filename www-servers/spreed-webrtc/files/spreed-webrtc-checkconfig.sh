#!/bin/sh

WEBRTC_CONF="${WEBRTC_CONF:-/etc/spreed-webrtc/spreed-webrtc.ini}"

if [ ! -e ${WEBRTC_CONF} ] ; then
	echo "Please setup ${WEBRTC_CONF} before starting spreed-webrtc" >&2
	echo "There are sample configurations in /etc/spreed-webrtc" >&2
	exit 1
fi
