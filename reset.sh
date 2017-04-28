#!/bin/bash

source ./backup.conf
@echo off
rm $out_dir/test1.log
rm $out_dir/test1.error.log
rm $tar_dir/test1.tar.gz
rm -rf /storage/backup-testing
mkdir -p /storage/backup-testing/testlogs
clear