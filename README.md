# scp

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with scp](#setup)
    * [What scp affects](#what-scp-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with scp](#beginning-with-scp)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

A Puppet Type and Provide to download files onto an agent via `scp`

## Module Description

This module gives you a nice way of invoking the `scp` (secure copy) command
to download files from other servers via `scp`.  By default, this provider will
login to the server hosting the files via `ssh` and perform `md5` validation
to determine whether the local copy needs to be updated or not.

Of course, you don't normally want to be using `scp` to download random files
onto computers in a non-random way (e.g., via Puppet), there are much better
ways of doing this, such as network shared storage and dedicated servers such
as [artifactory](http://www.jfrog.com/open-source/).

That said, sometimes you need a stop-gap solution so this module could be
something that will buy you enough time to get rid of `scp` and do things 
_properly_.

## Setup

### What scp affects

* provides a new type: `scp`

### Setup Requirements

* `scp` command in path
* `ssh` command in path
* `ssh` public/private keypair generated for *local* user who will be running
  the `scp` command (`root`)
* `ssh` configured to accept the key of the local user on the remote server
* At least one successful `ssh` login from the *local* user to the remote 
  server (to verify the `ssh` keys in `known_hosts`)

### Beginning with scp

_Ensure the above requirements are met_

*Downloading a file to a node*
```
scp { "/tmp/myfile.war":
  ensure => present
  source => "fred@build.mycompany.com/var/jenkins/data/myapp_current.war",
}
```
This would use the `fred` account on `build.mycompany.com` to download the file
at `/var/jenkins/data/myapp\_current.war` to the node where it will be saved at
`/tmp/myfile.war`.


## Usage
By default the `scp` type will perform remote verfication of md5 sums to check
whether the local copy of the file needs to be updated.  This can be disabled
in case this is generating excessive load or ssh access is locked down:
```
scp { "/tmp/myfile.war":
  ensure => present,
  source => "fred@build.mycompany.com/var/jenkins/data/myapp_current.war",
  verify => false,
}
``` 

## Reference

This module includes a single Type and Provider: `scp`

## Limitations

* Linux only
* Passwordless SSH only
* Runs as `root`
* You *must* manually SSH into the target machine as the local root user to
  accept it's key before attempting to use this module

