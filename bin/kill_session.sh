#!/usr/bin/env bash

ps -aux | egrep 'ERPApplication'| egrep -v grep | awk '{print $2}' | xargs  -n 1 kill -9
