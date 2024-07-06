#!/bin/make

default: help
help:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

nixos: nixos-flake-update nixos-rebuild home-manager ## Update nixos and home-manager and flakes

home-manager: ## Update home-manager configuration
	home-manager switch --flake '.#tcrha-nixos'

nixos-rebuild: ## Update nixos configuration
	sudo nixos-rebuild switch --flake '.#tcrha-nixos'

nixos-flake-update: ## Update nix flakes
	nix flake update
