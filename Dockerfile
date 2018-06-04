ARG BASEIMAGE_VERSION=${BASEIMAGE_VERSION}

FROM phusion/baseimage:${BASEIMAGE_VERSION}

MAINTAINER Yifans_Z <168@yifans.com>

RUN DEBIAN_FRONTEND=noninteractive
RUN locale-gen en_US.UTF-8

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV TERM xterm


#
#--------------------------------------------------------------------------
# Software's Installation
#--------------------------------------------------------------------------
#

RUN apt-get update && \
    apt-get install -y --allow-downgrades --allow-remove-essential \
        --allow-change-held-packages \
        pkg-config \
        libcurl4-openssl-dev \
        libedit-dev \
        libssl-dev \
        libxml2-dev \
        xz-utils \
        libsqlite3-dev \
        sqlite3 \
        git \
        curl \
        vim \
        nano \
        postgresql-client \
        libmysqlclient-dev \
        python \
        python-dev \
        python-pip \

    && curl -sSL https://bootstrap.pypa.io/get-pip.py | python \
    && pip install git+https://github.com/scrapy/scrapy.git \
    && pip install MySQL-python \

    && curl -sSL https://github.com/scrapy/scrapy/raw/master/extras/scrapy_bash_completion -o /etc/bash_completion.d/scrapy_bash_completion \
    && echo 'source /etc/bash_completion.d/scrapy_bash_completion' >> /root/.bashrc


# Source the bash
RUN . ~/.bashrc


#
#--------------------------------------------------------------------------
# Final Touch
#--------------------------------------------------------------------------
#


# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/log/lastlog /var/log/faillog

# Set default work directory
WORKDIR /var/www
