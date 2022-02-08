# The 'maxlab' home lab repo

This is a Chef code repository containing instructions to build out my home lab called 'maxlab'.

This code base exists to support my needs only, but I'm sharing it on github to support collaboration with others.

You are free to explore it and copy code as you like, but any support is limited to occasional questions to guide you in the right direction.

This code base was originally developed in the fall of 2019 as a learning project for my Chef skills.  Some of the code is basic and has flaws, while other code developed more recently feels more 'right' and higher quality to me.  If you explore, know this is not a textbook example of how to do things, but a set of possible methods and styles.

### My target platform is (Updated 2022-0204)+

* My lab is a mixture of Red Hat Enterprise Linux (RHEL) 8 on NAS servers and Proxmox as a hypervisor with virtual machines on other nodes.

* I'm using CentOS 8 for lab nodes and experimenting with CentOS Stream.

* The lab is small: four NAS, two hypervisors, and only a few virtual machines.
  * I don't need more, but this code base lets me expand and scale as I like.

## Goals

When I started this project, I had a list of "Principles" that served as goals for what I wanted to accomplish in an environment I control.

My expectations are more pragmatic now that I've seen the complexity involved and the time required to create code that is just for a home lab.

#### Original goals:

* Make generic cookbooks that could be shared in a community and allow their operation to be configured and customized.
* Place all configuration data in data bags to separate code from data.
* Use a sophisticated understanding of Chef attribute layers
* Use wrapper cookbooks to override the configuration of generic cookbooks
* Use wrapper cookbooks to extend the capabilities of generic cookbooks

#### Current goals:

* **Write cookbooks focused on my personal needs but allow for flexibility of use in the future.**
  * The time required to create high quality generic cookbooks is rewarding in community projects but not this personal project.
* **Use policyfiles to organize services as runlists, attributes and dependencies.**
  * I love policyfiles for fixing so many things that were broken without them.
  * Never use roles.
* **Use data bags where appropriate to configure the operation of cookbooks.**
  * Data bags (such as config_network) can make organizing a large list of similar information (like network nodes) very easy to understand and maintain.
* **Use attributes within policyfiles to configure services.**
  * This allows clear documentation of how service deployment A and service deployment B differ.
* **Code should be documented.**
  * I continue to strive to find a balance between too little and too much, but none is not acceptable.
* **Code should be clear and readable.**
  * When possible, I'd like to return to code a year later and be able to understand it because it is kept simple in visual presentation and how it implements steps and algorithms.
  * I'd rather it be slower and verbose than fast and clever.
* **Code should have Test Kitchen automated testing.**
  * At least some. At least the ability to execute 'kitchen test' and have it demonstrate it can complete without error.
  * I don't write comprehensive test because after writing code I'll deploy it and test it for real.
* **Continue to aim towards cloud-centric operation.**
  * Deploy services via Chef (not by hand)
  * Deploy updates and modifications via Chef (not by hand)
  * Destroy a node and build a new node instead of excessively debugging a faulty node
  * Nodes should be able to provision without another node in the lab as a dependency.

#### Where my code is imperfect

* Sometimes I don't have or want to take the time to do things right and the solution is a hack
* Sometimes I'm not aware of a better solution and I use a legacy method
* Sometimes I'm focused on simple, readable code rather than clever tricks.
