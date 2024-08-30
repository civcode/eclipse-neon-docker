FROM ubuntu:16.04

ARG DEBIAN_FRONTEND=noninteractive

# Set the environment variable for the eclipse executable path in the container
ARG ECLIPSE_EXECUTABLE_PATH="/workspace/powerlink/eclipse/eclipse-rcp-neon-3-linux-gtk-x86_64/eclipse"

RUN apt-get update && apt-get install -y \
    default-jre \
    libboost-all-dev \
    libcanberra-gtk-module \
    mesa-utils \
    tmux \
    wget \ 
    && rm -rf /var/lib/apt/lists/*

# Problem with installing eclipse in the container
# => Plugins will only be installed in the container and not in the host
# => Solution: Install eclipse in the host

# Create a symlink to the eclipse executable
RUN ln -s ${ECLIPSE_EXECUTABLE_PATH} /usr/bin/eclipse

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

CMD ["sleep", "infinity", "1000"]

