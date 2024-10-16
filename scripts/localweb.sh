#! /bin/sh

set -e

export MIX_ENV=dev
export MIX_TARGET=host

mix do deps.get, assets.deploy
MIX_TARGET=rpi0 mix do deps.get

iex -S mix phx.server
