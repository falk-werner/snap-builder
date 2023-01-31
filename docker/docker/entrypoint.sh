#!/bin/bash

mount -o rw,nosuid,nodev,noexec,relatime securityfs -t securityfs /sys/kernel/security

mount -t tmpfs tmpfs /run
mount -t tmpfs tmpfs /run/lock

exec /sbin/init