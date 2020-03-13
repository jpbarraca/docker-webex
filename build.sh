#!/bin/bash

docker rm --force webex >/dev/null 2>&1
docker build --tag=webex .
