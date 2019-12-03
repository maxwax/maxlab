# The 'maxlab' home lab repo

This is a Chef code repository containing instructions to build out my home lab called 'maxlab'.

This code base exists to support my needs only, but I'm sharing it on github to support collaboration with others.

You are free to explore it and copy code as you like, but any support is limited to occasional questions to guide you in the right direction.

## My target platform is:

* Centos 8.1 VM nodes running on a KVM based Proxmox 6 hypervisor cluster
* SELinux enabled in enforcing mode
* firewalld for network firewalling
* Limited support in some recipes for Centos 7 and Centos 6

## Principles

I deploy services using the following principles:

* **Cookbooks should contain logic** on how to deploy services

* **Data bags provide configuration choices** such as names of resources, directories to be used, sizes of filesystems, etc.

Ideally, a generic-enough cookbook with two custom data bags driving the configuration should allow two unique instances of the service to be deployed only by modifying the data bag and not the code.

* Code should be sufficiently documented.  I want enough comments so that I can quickly and easily understand the intentions and the implementation of my code when reviewing it many months after writing it.

* Code should prioritize readability over speed or efficiency.  This Chef code and knowing what its supposed to do and how it does it is more important than trying to be clever or make it go faster.

### Where I'm lazy and imperfect

Since this is a personal project without a collaborative code review, you'll see me break some of my principles.  Sometimes my code will be less generic than it should and there won't be enough support for non-target platforms or features I'm not using.

## Community Cookbooks

In the past, I've written wrapper cookbooks with wrapper cookbook attributes that replace community cookbook default attributes.  This is how the Chef community teaches this practice and its OK.  This lets me leverage community cookbook's logic to get things done, but *it mixes code and data in the wrapper cookbook and defeats my principles.*

So in this lab, I'll be using a method of storing my configuration values in a data bag, loading the values into a wrapper cookbook recipe and then using those values to over ride the community cookbook's default values.  This lets me *wrap* a community cookbook but using my data bag based pattern.

