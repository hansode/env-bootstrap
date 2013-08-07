env-bootstrap
=============

Quick setup environment

Installing env-bootstrap
------------------------

    $ git clone https://github.com/hansode/env-bootstrap.git

Adding work user
----------------
Add new user and make home directory.

    # ./add-work-user.sh

The user name and home directory depend on Linux distoribution name.

+       ``rhel``: /home/rhel
+     ``fedora``: /home/fedora
+     ``centos``: /home/centos
+ ``scientific``: /home/scientific
+     ``ubuntu``: /home/ubuntu
+     ``debian``: /home/debian

Building personal environment
-----------------------------
Install my github project to ``~/work/git/github.com/``.

    $ ./build-personal-env.sh

+ [https://github.com/hansode/dotfiles](https://github.com/hansode/dotfiles)
+ [https://github.com/hansode/env-builder](https://github.com/hansode/env-builder)
