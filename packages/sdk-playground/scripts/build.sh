#!/usr/bin/env bash

ROOT_DIR=$(dirname $0)

cd "${ROOT_DIR}/.."
ROOT_DIR=$(pwd)

ACTION="help"
ENV=""

for i in "$@"
do
case ${i} in
    kovan)
    ACTION="build"
    ENV="kovan"
    ;;
    rinkeby)
    ACTION="build"
    ENV="rinkeby"
    ;;
    ropsten)
    ACTION="build"
    ENV="ropsten"
    ;;
esac
done

build_dist() {
  export REACT_APP_SDK_ENV=${ENV}
  export REACT_APP_SHOW_HELP=0

  rm -r -f ./build-${ENV}
  ./node_modules/.bin/react-scripts build
  mv ./build ./build-${ENV}
}

case ${ACTION} in
    build)
    build_dist
    ;;
    help)
    echo "usage: ./build.sh [kovan|rinkeby|ropsten]"
    ;;
esac