#! /bin/bash
#
# Provisioning script for Ansible control node

#--------- Bash settings ------------------------------------------------------

# Enable "Bash strict mode"
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't mask errors in piped commands

#--------- Variables ----------------------------------------------------------

# Location of provisioning scripts and files
export readonly PROVISIONING_SCRIPTS="/vagrant/scripts/"
# Location of files to be copied to this server
export readonly PROVISIONING_FILES="${PROVISIONING_SCRIPTS}/${HOSTNAME}"

#---------- Provision host ----------------------------------------------------

log() {
  printf '\e[0;33m[LOG]  %s\e[0m\n' "${*}" 1>&2
}

log "Starting server specific provisioning tasks on host ${HOSTNAME}"

log "Set up Docker's apt repository"

# Add Docker's official GPG key:
apt-get install ca-certificates curl -y
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
   tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y

log "Install the Docker packages"

apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

log "Add vagrant user to the docker group"

usermod -aG docker vagrant
