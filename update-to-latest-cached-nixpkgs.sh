#!/usr/bin/env nix-shell
#!nix-shell -i bash -p curl jq

# Fetch the latest cached nixos-unstable revision
latest_revision=$(curl -sL "https://monitoring.nixos.org/prometheus/api/v1/query?query=channel_revision" | jq -r '.data.result[] | select(.metric.channel=="nixos-unstable") | .metric.revision')

if [ -n "$latest_revision" ]; then
  echo "Updating nixpkgs input to the latest cached nixos-unstable revision: \"$latest_revision\""
  nix flake update --override-input nixpkgs "github:nixos/nixpkgs/$latest_revision"
else
  echo "Failed to fetch the latest nixos-unstable revision."
fi
