#!/bin/bash

KEYPAIR=./crank.key

curl 'https://raw.githubusercontent.com/blockworks-foundation/mango-client-ts/main/src/ids.json' >ids.json
IDS_PATH=./ids.json

GROUP="BTC_ETH_SOL_SRM_USDC"

CLUSTER=devnet
CLUSTER_URL=$(cat $IDS_PATH | jq ".cluster_urls.$CLUSTER" -r)
DEX_PROGRAM_ID=$(cat $IDS_PATH | jq ".$CLUSTER.dex_program_id" -r)
SYM_SELECTOR=".$CLUSTER.mango_groups.$GROUP.symbols"
MARKET=$(cat $IDS_PATH | jq ".$CLUSTER.spot_markets|.[\"$1/$2\"]" -r)
BASE_MINT=$(cat $IDS_PATH | jq "$SYM_SELECTOR.$1" -r)
QUOTE_MINT=$(cat $IDS_PATH | jq "$SYM_SELECTOR.$2" -r)

solana airdrop --url $CLUSTER_URL 1 $KEYPAIR >/dev/null
spl-token create-account --url $CLUSTER_URL --owner $KEYPAIR --fee-payer $KEYPAIR $BASE_MINT >/dev/null
spl-token create-account --url $CLUSTER_URL --owner $KEYPAIR --fee-payer $KEYPAIR $QUOTE_MINT >/dev/null
BASE_WALLET=$(spl-token accounts --verbose --url $CLUSTER_URL --owner $KEYPAIR $BASE_MINT | tail -1 | cut -d' ' -f1)
QUOTE_WALLET=$(spl-token accounts --verbose --url $CLUSTER_URL --owner $KEYPAIR $QUOTE_MINT | tail -1 | cut -d' ' -f1)

echo "CLUSTER='$CLUSTER'"
echo "DEX_PROGRAM_ID='$DEX_PROGRAM_ID'"
echo "KEYPAIR='$KEYPAIR'"
echo "MARKET='$MARKET'"
echo "BASE_WALLET='$BASE_WALLET'"
echo "QUOTE_WALLET='$QUOTE_WALLET'"
