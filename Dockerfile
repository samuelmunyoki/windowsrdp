FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
    qemu-kvm \
    build-essential \
    libvirt-daemon-system \
    libvirt-dev \
    curl \
    net-tools \
    jq && \
    apt-get clean

# Install the linux-image package
RUN apt-get install -y linux-image-$(uname -r) || true

# Run debug output for package resolver
RUN apt-get install -y -o Debug::pkgProblemResolver=yes

# Remove unnecessary packages
RUN apt-get autoremove -y && \
    apt-get clean

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    TERM=xterm-256color

# Final cleanup
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean


# Download Vagrant and its dependencies
RUN VAGRANT_VERSION=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/vagrant | jq -r -M '.current_version') && \
    curl -LO "https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_x86_64.deb" && \
    dpkg -i "vagrant_${VAGRANT_VERSION}_x86_64.deb" && \
    rm "vagrant_${VAGRANT_VERSION}_x86_64.deb"

# Install Vagrant plugins
RUN vagrant plugin install vagrant-libvirt

# Add Vagrant box
RUN vagrant box add --provider libvirt peru/windows-10-enterprise-x64-eval

# Initialize Vagrant project
RUN vagrant init peru/windows-10-enterprise-x64-eval


COPY Vagrantfile /
COPY startup.sh /

ENTRYPOINT ["/startup.sh"]

CMD ["/bin/bash"]
