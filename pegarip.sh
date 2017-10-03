#!/bin/bash

IP="`hostname -I | cut -f1 -d ' '`" 

echo "$IP"
