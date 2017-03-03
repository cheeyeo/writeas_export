Everyone knows about pushing your dotfiles to [github][1]/[bitbucket][2] or whatever version control provider you like best but not many people implement a way to copy or link the dotfiles. Lots of people use [bloated][3] [gems][4] to manage the linking or even write their own, but to me, these are just over-engineered for my needs. My solution is to use a tool that will be already on everyone's machine [GNU/Make][6] - nice and straightforward!

<!--more-->
Below is a copy of my Makefile which I used to keep my desktop (archlinux) and my laptop (Slackware) in sync. You can also find it on my [git account][5].

## Makefile

<pre><code class="bash">

DOTFILES = $(shell pwd)

all : linkfiles linkfolders linkmisc

linkfiles:: bashrc vimrc xinitrc Xresources
	for file in $^; do ln -fs $(DOTFILES)/$$file ${HOME}/.$$file; done

linkfolders:: vim ncmpcpp
	for folder in $^; do ln -fns $(DOTFILES)/$$folder ${HOME}/.$$folder; done

linkmisc:: bin dwm
	for folder in $^; do ln -fns $(DOTFILES)/$$folder ${HOME}/$$folder; done
</code>
</pre>

[1]: http://github.com
[2]: http://bitbucket.com
[3]: https://rubygems.org/gems/dotfiles
[4]: https://github.com/technicalpickles/homesick
[5]: http://github.com/beardyjay/dotfiles
[6]: http://www.gnu.org/software/make/