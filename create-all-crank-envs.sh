#!/bin/bash

# install solana
# sh -c "$(curl -sSfL https://release.solana.com/v1.7.1/install)"

mkdir -p markets
./create-crank-env.sh BTC USDC >markets/BTCUSDC.env
./create-crank-env.sh ETH USDC >markets/ETHUSDC.env
./create-crank-env.sh SOL USDC >markets/SOLUSDC.env
./create-crank-env.sh SRM USDC >markets/SRMUSDC.env
