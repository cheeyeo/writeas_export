In the past I have always had issues with some security apps that require a lot of dependencies or are quite a pain to setup and configure, tools like [Metasploit][metasploit] where the ruby dependencies are quite large is a good example of this.

<!--more-->

A lot of people would just install [Kali][kali] on a VM or boot the laptop and run the tool. However, this can be quite a time-consuming process to do, and this is where [Docker][docker] shines.

I run [Warvox][warvox] quite often, and it can be a pain to build at times, I just create an EC2 instance or throw away VPS to install Debian as it seems to be an easier way to get Warvox up and running however with docker this is now trivial to do!

I won't go into how you use Docker etc. as a quick Google will give you plenty of guides to get you started. Below, however, is a Dockerfile which will grab the master branch from Warvox, install the dependencies, build and install.

```bash
FROM debian:latest
MAINTAINER Jay Scott <jay@beardyjay.co.uk>

RUN apt-get update && apt-get -y install \
  gnuplot \
  lame \
  build-essential \
  libssl-dev \
  libcurl4-openssl-dev \
  postgresql-contrib \
  git-core \
  curl \
  libpq-dev \
  ruby2.1 \
  bundler \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /home/warvox
RUN git clone https://github.com/rapid7/warvox /home/warvox \
  && ln -s /usr/bin/ruby2.1 /usr/bin/ruby \
  && bundle install \
  && make

ADD setup.sh /
EXPOSE 7777

CMD ["/setup.sh"]
```

Using this Dockerfile, you can build an image with Warvox installed and ready to go. To make it even easier, you can just pull down the latest image I have for Warvox from [Dockerhub][dockerhub] and use that instead of building your own.

```bash
# Get the postgres and warvox image
docker pull postgres
docker pull beardyjay/warvox

# Run a postgres container in the background
docker run -d --name=postgres postgres

# Run a Warvox container linking to postgres
docker run -d -p 7777:7777 -ti --link postgres:db beardyjay/warvox
```

After you have downloaded the image you can be up and running with Warvox in seconds. The good thing too is you only need to download the images once!

<script type="text/javascript" src="https://asciinema.org/a/elpqc2o4n9se8vhiood9s5dro.js" id="asciicast-elpqc2o4n9se8vhiood9s5dro" async></script>

Even though I think Docker is a fantastic tool I am not sure about using Docker in a production environment other than tools such as [Ansible][ansible] but it is super handy for developing and testing out applications.

On a side note, I have also started using Docker to build images for other security related tools which you can find on my [DockerHub][dockerhub] page so feel free to have a look.

[metasploit]: http://www.metasploit.com/
[warvox]: https://github.com/rapid7/warvox
[docker]: https://www.docker.com/
[dockerhub]: https://hub.docker.com/r/beardyjay/
[kali]: https://www.kali.org/
[ansible]: https://www.ansible.com/