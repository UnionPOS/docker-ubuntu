#!/usr/bin/env bash

# TUI functions echo to stderr
# this allows for UI elements to be displayed when run from tty
# yet not interfere with output when run otherwise

# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"

################################################################################
# TUI Functions
################################################################################

function banner() {
  clear
  echo -e "$COL_GREEN"'
      ___           ___                       ___           ___
     /\__\         /\__\          ___        /\  \         /\__\
    /:/  /        /::|  |        /\  \      /::\  \       /::|  |
   /:/  /        /:|:|  |        \:\  \    /:/\:\  \     /:|:|  |
  /:/  /  ___   /:/|:|  |__      /::\__\  /:/  \:\  \   /:/|:|  |__
 /:/__/  /\__\ /:/ |:| /\__\  __/:/\/__/ /:/__/ \:\__\ /:/ |:| /\__\
 \:\  \ /:/  / \/__|:|/:/  / /\/:/  /    \:\  \ /:/  / \/__|:|/:/  /
  \:\  /:/  /      |:/:/  /  \::/__/      \:\  /:/  /      |:/:/  /
   \:\/:/  /       |::/  /    \:\__\       \:\/:/  /       |::/  /
    \::/  /        /:/  /      \/__/        \::/  /        /:/  /
     \/__/         \/__/                     \/__/         \/__/
'"$COL_RESET" 1>&2
}

function ok() {
  echo -e "$COL_GREEN[ok]$COL_RESET $1" 1>&2
}

function bot() {
  echo -e "\n$COL_GREEN\[._.]/$COL_RESET - $1" 1>&2
}

function running() {
  echo -en "$COL_YELLOW ⇒ $COL_RESET $1: " 1>&2
}

function action() {
  echo -e "\n$COL_YELLOW[action]:$COL_RESET\n ⇒ $1..." 1>&2
}

function warn() {
  echo -e "$COL_YELLOW[warning]$COL_RESET $1" 1>&2
}

function error() {
  echo -e "\a$COL_RED[error]$COL_RESET $1" 1>&2
}

function info() {
  echo -e "$COL_GREEN[info]$COL_RESET $1" 1>&2
}

function line() {
  echo -e "------------------------------------------------------------------------------------"
}

function die() {
  echo "$@" 1>&2
  exit 1
}

function is_empty() {
  local var="$1"
  [ -z "$var" ]
}

function is_not_empty() {
  local var="$1"
  [ -n "$var" ]
}

function is_file() {
  local file="$1"
  [ -f "$file" ]
}

function is_not_file() {
  local file="$1"
  [ ! -f "$file" ]
}

function is_dir() {
  local dir="$1"
  [ -d "$dir" ]
}

function is_not_dir() {
  local dir="$1"
  [ ! -d "$dir" ]
}
