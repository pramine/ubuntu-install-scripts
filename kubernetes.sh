#!/bin/bash

if ! which kubectl &>/dev/null; then
  echo Install kubectl
  curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
  chmod +x ./kubectl
  sudo mv ./kubectl /usr/local/bin/kubectl
fi

if ! which minikube &>/dev/null; then
  echo Install Minikube
  curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  chmod +x minikube
  sudo mv minikube /usr/local/bin/
fi

echo Kubectl aliases
mkdir -p ~/aliases
curl -s https://raw.githubusercontent.com/ahmetb/kubectl-alias/master/.kubectl_aliases > ~/aliases/kubectl_aliases

if ! which helm &>/dev/null; then
  echo Install Helm
  curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
fi

if ! which kind &>/dev/null; then
  echo Install KinD
  curl -Lo ./kind https://kind.sigs.k8s.io/dl/$(curl -sL https://api.github.com/repos/kubernetes-sigs/kind/releases/latest | jq -r '.tag_name')/kind-$(uname)-amd64
  chmod +x ./kind
  sudo mv ./kind /usr/bin/kind
  kind create cluster test
  sudo su
  kind completion zsh > /usr/local/share/zsh/site-functions/_kind
  exit
  autoload -U compinit
  compinit
fi

if ! which dive &>/dev/null; then
  echo Install Dive
  dive_deb=$(curl -sL https://api.github.com/repos/wagoodman/dive/releases/latest | jq -r '.assets[].browser_download_url' | grep linux_amd64.deb)
  wget -O ./dive.deb $dive_deb
  sudo apt install ./dive.deb
  rm ./dive.deb
fi

if ! which dockle &>/dev/null; then
  echo Install Dockle
  dockle_deb=$(curl -sL https://api.github.com/repos/goodwithtech/dockle/releases/latest | jq -r '.assets[].browser_download_url' | grep -i Linux-64bit.deb)
  wget -O ./dockle.deb $dockle_deb
  sudo apt install ./dockle.deb
  rm ./dockle.deb
fi
