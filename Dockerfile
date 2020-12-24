
FROM debian

USER root

RUN sed -i "s@http://deb.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        build-essential \
        default-libmysqlclient-dev \
        libpq-dev \
        unixodbc \
        unixodbc-dev \
        libssl-dev \
        libffi-dev \
        zlib1g-dev \
        libxml2-dev \
        libxslt-dev \
        libsasl2-dev \
        wget \
        vim \
        procps \
        curl \
        net-tools \
        gcc g++ \
    && rm -rf /var/lib/apt/lists/*

# install jupyter
ADD Miniconda3-latest-Linux-x86_64.sh /miniconda.sh
RUN /bin/bash /miniconda.sh -b -p /opt/conda && rm /miniconda.sh
ENV PATH /opt/conda/bin:$PATH
RUN conda install -y  jupyter

# install javascript kernel
ADD ./node-v14.15.1-linux-x64.tar.xz /
RUN chmod 777 /node-v14.15.1-linux-x64/bin/* \
    && ln -s /node-v14.15.1-linux-x64/bin/node /usr/bin/node \
    && ln -s /node-v14.15.1-linux-x64/bin/npm /usr/bin/npm \
    && npm install -g ijavascript --unsafe-perm \
    && /node-v14.15.1-linux-x64/bin/ijsinstall --spec-path=full

# install cpp kernel
RUN conda install -y xeus-cling -c conda-forge

# install c kernel
RUN pip install jupyter-c-kernel && install_c_kernel

RUN mkdir /notebooks
CMD jupyter notebook --ip=0.0.0.0 --port=9999 --NotebookApp.token='' --NotebookApp.password='' --allow-root --notebook-dir='/notebooks'