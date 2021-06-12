#!/bin/bash
set -x

source ~/.cargo/env
source $1
./target/release/crank $CLUSTER consume-events --dex-program-id $DEX_PROGRAM_ID --payer $KEYPAIR --market $MARKET --coin-wallet $BASE_WALLET --pc-wallet $QUOTE_WALLET --num-workers 1 --events-per-worker 5
