HOSTNAME = $(shell hostname)

NIX_FILES = $(shell find . -name '*.nix' -type f)

ifndef HOSTNAME
  $(error Hostname unknown)
endif

switch:
  nix-rebuild switch --use-remote-sudo --flake .#${HOSTNAME} -L

boot:
  nix-rebuild boot --use-remote-sudo --flake .#${HOSTNAME} -L

test:
  nix-rebuild test --use-remote-sudo --flake .#{HOSTNAME} -L

vm:
  nix-rebuild build-vm --use-remote-sudo --flake .#{HOSTNAME} -L

update:
  nix flake update

upgrade:
  make update && make switch
