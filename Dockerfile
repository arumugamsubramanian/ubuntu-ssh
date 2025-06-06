# Use the official image as a parent image
FROM ubuntu

# Update the system
RUN apt-get update && apt-get upgrade -y

# Install OpenSSH Server and tex libraries for resume creation
RUN apt-get install --fix-missing -y openssh-server curl unzip texlive texlive-base texlive-latex-extra texlive-fonts-extra

# Set up configuration for SSH
RUN mkdir /var/run/sshd
RUN echo 'root:root123' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "AuthorizedKeysFile .ssh/authorized_keys" >> /etc/ssh/sshd_config

# SSH login fix. Otherwise, user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN mkdir -p /root/.ssh && \
    echo -e "Host *\n\tStrictHostKeyChecking no\n\tUserKnownHostsFile=/dev/null\n" >> /root/.ssh/config && \
    chmod 600 /root/.ssh/config

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

ARG TERRAFORM_VERSION=1.2.0
ARG TARGETARCH

RUN echo "TARGETARCH is $TARGETARCH"

RUN curl -sSLo terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${TARGETARCH}.zip && \
    unzip terraform.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform.zip

# Expose the SSH port
EXPOSE 22

# Run SSH
CMD ["/usr/sbin/sshd", "-D"]
