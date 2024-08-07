FROM ubuntu:16.04

ARG DEBIAN_FRONTEND=noninteractive

ARG ECLIPSE_DOWNLOAD_URL="https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/neon/3/eclipse-rcp-neon-3-linux-gtk-x86_64.tar.gz"
ARG ECLIPSE_TAR_FILE=eclipse-rcp-neon-3-linux-gtk-x86_64.tar.gz
ARG ECLIPSE_TARGET_DIR="/opt/eclipse"

RUN apt-get update && apt-get install -y \
    default-jre \
    libboost-all-dev \
    libcanberra-gtk-module \
    mesa-utils \
    tmux \
    wget \ 
    && rm -rf /var/lib/apt/lists/*

# RUN mkdir -p ${ECLIPSE_TARGET_DIR} \
#     && cd ${ECLIPSE_TARGET_DIR} \
#     && wget -O ${ECLIPSE_TAR_FILE} ${ECLIPSE_DOWNLOAD_URL} \
#     && tar -xvzf ${ECLIPSE_TAR_FILE} -C ${ECLIPSE_TARGET_DIR} 

# Download Eclipse
ADD ${ECLIPSE_DOWNLOAD_URL} ${ECLIPSE_TAR_FILE}

RUN mkdir -p ${ECLIPSE_TARGET_DIR} \
   && tar -xvzf ${ECLIPSE_TAR_FILE} -C ${ECLIPSE_TARGET_DIR} \
   && rm -f ${ECLIPSE_TAR_FILE}

# Create a non-root user
RUN adduser --disabled-password --gecos "" powerlink
USER powerlink

# Modify .bashrc
RUN echo "alias l='ls -1'" >> ~/.bashrc && \
    echo "alias ll='ls -lah'" >> ~/.bashrc && \
    echo "alias 'cd..'='cd ..'" >> ~/.bashrc && \
    echo "alias tmux='tmux -2'" >> ~/.bashrc && \
    # make bash autocomplete write every suggestion in a separate line
    echo "bind 'set completion-display-width 0'" >> ~/.bashrc
    
# Ensure .bashrc is sourced when a new shell session starts
RUN echo 'source ~/.bashrc' >> ~/.bash_profile

CMD ["sleep", "1000"]

