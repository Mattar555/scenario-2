#!/bin/sh

oc exec -it $1 -- runmqsc QUICKSTART < mq_ace_lab.mqsc
