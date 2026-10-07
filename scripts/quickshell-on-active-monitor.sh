#!/usr/bin/env bash

set -euo pipefail

target=${1:?"usage: quickshell-on-active-monitor.sh <target> [method] [args...]"}
method=${2:-toggle}

if [[ $# -gt 0 ]]; then
    shift
fi

if [[ $# -gt 0 ]]; then
    shift
fi

monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name' | head -n1)

if [[ -z "$monitor" ]]; then
    echo "Could not determine the focused monitor." >&2
    exit 1
fi

quickshell ipc call "$target" "$method" "$monitor" "$@"
