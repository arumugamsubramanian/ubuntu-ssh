# Use the official image as a parent image
FROM ubuntu

# Update the system
RUN apt-get update && apt-get upgrade -y

# Install OpenSSH Server and tex libraries for resume creation
RUN apt-get install --fix-missing -y openssh-server texlive texlive-base texlive-latex-extra texlive-fonts-extra

# Set up configuration for SSH
RUN mkdir /var/run/sshd
RUN echo 'root:root123' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise, user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Expose the SSH port
EXPOSE 22

# Run SSH
CMD ["/usr/sbin/sshd", "-D"]
