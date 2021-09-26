#!bin/bash

PUBLIC_KEY=$1
PRIVATE_KEY_PATH=$2
MIN_WALLET_BALANCE=1
DEV_NETWORK_URL=https://api.devnet.solana.com

# Function to check pre- and post-conditions
check_condition() {
    if [ $1 ] 
    then 
        echo -e $2
        echo "...exiting"
        exit 1
    fi
}

# Verify wallet
echo "...verifying wallet"
solana-keygen verify $PUBLIC_KEY $PRIVATE_KEY_PATH > /dev/null
check_condition "$? -ne 0" "could not verify wallet"

# Check that wallet balance is greater than 1 sol
echo "...checking wallet balance"
BALANCE=$(solana balance $PUBLIC_KEY --url $DEV_NETWORK_URL | awk '{ print $1 }')
check_condition "$? -ne 0" "could not get balance"
check_condition "$(echo "$BALANCE < $MIN_WALLET_BALANCE" | bc) -ne 0" "balance should be at least 1 SOL"

# Set config network url and keypair
echo "...setting config network url and keypair"
solana config set --url $DEV_NETWORK_URL --keypair $PRIVATE_KEY_PATH > /dev/null

# Create a token type with zero decimal places
echo "...creating a token type with zero decimal places"
TOKEN=$(spl-token create-token --decimals 0 | awk '{ print $3 }')
check_condition "$? -ne 0" "could not create token type" 

# Create an account to hold tokens of this new type
echo "...creating an account to hold tokens of this new type"
ACCOUNT=$(spl-token create-account $TOKEN | awk '{ print $3 }')
check_condition "$? -ne 0" "could not create account" 

# Mint only one token into the account
echo "...minting only one token into the account"
spl-token mint $TOKEN 1 $ACCOUNT > /dev/null
check_condition "$? -ne 0" "could not mint token for\n token: $TOKEN\n account: $ACCOUNT" 

# Disable future minting
echo "...disabling future minting"
spl-token authorize $TOKEN mint --disable > /dev/null
check_condition "$? -ne 0" "could not disable future minting for\n token: $TOKEN\n account: $ACCOUNT" 

echo "done!"

# Print account info
spl-token account-info $TOKEN

exit 0