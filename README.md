# solana-create-nft
## Description
A bash script that creates an NFT on the Solana **dev network** for the purpose of having some 
fun and learning a bit more about NFTs.

Input
* `<devnet_wallet>` - the public key for your Solana file system devnet wallet
* `<file_path>` - the file path to the keypair for your file system wallet

Sample screen output
```
...verifying wallet
...checking wallet balance
...setting config network url and keypair
...creating a token type with zero decimal places
...creating an account to hold tokens of this new type
...minting only one token into the account
...disabling future minting
done!

Address: 3EWR9HcNqnGnUkv7yQ4GCBQZsYQjSEFKXy9yeZdcX3xG
Balance: 1
Mint: H8nBHWcvxTv4fRdCotdjuexWsDyyGyLoKqDchHBNPUwj
Owner: 5PzYKHsb8ZoMgS7p2WE3y3M6L3crQc4d9f4hpD3APixx
State: Initialized
Delegation: (not set)
Close authority: (not set)
```

## Installation
```
git clone https://github.com/surferwat/solana-create-nft.git
```
## Usage
```
bash index.sh <devnet_wallet> <file_path>
```
## References
* [File System Wallet](https://docs.solana.com/wallet-guide/file-system-wallet)
* [Send and Receive Tokens](https://docs.solana.com/cli/transfer-tokens)
* [Token Program](https://spl.solana.com/token)
