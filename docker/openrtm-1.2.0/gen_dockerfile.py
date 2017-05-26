#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" script for generate dockerfile templates

This is xxx
"""

import sys
import os
import shutil

dockerfile_template = '''
FROM @IMAGE_NAME@
MAINTAINER @AUTHOR@

ENV DEBIAN_FRONTEND noninteractive
COPY pkg_install.sh /
RUN set -x && \\
    apt-get update -qq && \\
    apt-get install -y bc iputils-ping net-tools && \\
    ./pkg_install.sh -l all -d --yes

ENTRYPOINT ["/bin/bash", "-c"]
EXPOSE 80
'''

class DockerImage:
    def __init__(self, d, dv, i, a, rvmj, rvmn, rvrv):
        self._dist = d
        self._dist_version = dv
        self._image = i
        self._arch = a
        self._rtm_version_major = rvmj
        self._rtm_version_minor = rvmn
        self._rtm_version_revision = rvrv

    def create(self):
        dist = self._dist + self._dist_version + self._arch
        top_path = dist + '-openrtm' + self._rtm_version_major + self._rtm_version_minor + self._rtm_version_revision
        if not os.path.exists(top_path):
            os.makedirs(top_path)
        shutil.copyfile("pkg_install_ubuntu.sh", top_path + "/pkg_install.sh")
        f = open(top_path + '/Dockerfile', 'w')
        print f
        m = dockerfile_template
        m = m.replace('@AUTHOR@', 'takahasi')
        m = m.replace('@IMAGE_NAME@', self._image)
        f.write(m)
        f.close()


DockerImage('ubuntu', '1704', 'ubuntu:17.04', 'x64', '1', '2', '0').create()
DockerImage('ubuntu', '1610', 'ubuntu:16.10', 'x64', '1', '2', '0').create()
DockerImage('ubuntu', '1604', 'ubuntu:16.04', 'x64', '1', '2', '0').create()
DockerImage('ubuntu', '1404', 'ubuntu:14.04', 'x64', '1', '2', '0').create()
DockerImage('ubuntu', '1204', 'ubuntu:12.04', 'x64', '1', '2', '0').create()
#DockerImage('debian', '8', 'debian:8', 'x64', '1', '1', '2').create()
#DockerImage('debian', '9', 'debian:9', 'x64', '1', '1', '2').create()
#DockerImage('fedora', '24', 'debian:24', 'x64', '1', '1', '2').create()
#DockerImage('fedora', '25', 'fedora:25', 'x64', '1', '1', '2').create()
