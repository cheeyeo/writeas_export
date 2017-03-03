**TLDR;** [Docker][1] is a brilliant tool for development/testing/CI but should not be used for everything just for the sake of it. 

I am doubtful on the practicalities of using it in production from an OPS/Security point of view instead of tools such as [Ansible][2]/[Chef][4]/[Puppet][5].

<!--more-->

**Implementing Docker correctly in real world applications is complicated.**

Please mind that this is only my thoughts on Docker from a security/operations point of view.

### Gives Developers more responsibility

Docker gives developers more control over their working environment; I am totally fine with this as long as there is a review in between a new container being pushed to production OR there is an op focused DevOps working directly with the development team.

**Why**?

  * Most developers will not have security in mind and might not be looking at things from the point of view-ops do.
  * Have they configured applications correctly? 
  * Have they just blindly used something from DockerHub?

### Security

Just imagine you have 100s of Docker containers running in production and then boom shellshock v2 is released - how do you go about patching it? How do you know what containers are affected?

If you are using tools like Chef, Puppet or Ansible then it would be a trivial task to do, for Ansible it would be a one liner to get the package version and then to patch it for example!

Now for Docker, I would have no idea where to start to find all the affected containers out with checking the base images but let's assume we do know what containers are affected. We would still have to do the following to fix them all:

  * Rebuilding the base images.
  * Rebuild the containers.
  * Deploy the new containers.

Sounds like a pain in the arse to me.

### Added Complexity

I have heard and see that people are just now using docker for the sake of it. Need to run that Go binary, let's build a Docker image and container for that! Need a new CI Runner? Lets provision a host, configure it with ansible, build the image, build the container/app then deploy it!

Of course, if you want to manage containers you will most likely have to use another tool such as [Rancher][6], [Kubernetes][3] etc which just adds another layer of things to go wrong.

I would hate to try and debug issues with a proper Docker stack.

End Rant!

[1]: http://docker.com
[2]: http://ansible.com
[3]: http://kubernetes.io
[4]: http://chef.io
[5]: http://puppet.com
[6]: http://rancher.com/