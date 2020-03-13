#!/bin/bash

export ENV_HOME=/opt/webex
export FIREFOX_HOME=$ENV_HOME/firefox
export MOZ_PLUGIN_PATH=$ENV_HOME/firefox/plugins
export JAVA_HOME=$ENV_HOME/jre
export PATH=$JAVA_HOME/bin:$PATH

#export JPI_PLUGIN2_DEBUG=1

$FIREFOX_HOME/firefox --no-remote -CreateProfile Webex
$FIREFOX_HOME/firefox --no-remote -P Webex https://meetings.webex.com
