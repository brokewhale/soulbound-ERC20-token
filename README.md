# soulbound-ERC20-token

Deployed to mumbai at https://mumbai.polygonscan.com/address/0xd84e49b9afaad09d2163933587cd8ec78c6e7f53

# Soulbound ERC20 Token

## Open development environment on gitpod

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/brokewhale/soulbound-ERC20-token)

- [Installation](#installation)
  - [Requirements](#requirements)
  - [Getting Started / Quickstart](#getting-started--quickstart)
  - [Testing](#testing)
- [Deploying to a network](#deploying-to-a-network)

  - [Setup](#setup)
  - [Deploying](#deploying)

- [Thank You!](#thank-you)
  - [Resources](#resources)

# Installation

## Requirements

- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Foundry / Foundryup](https://github.com/gakonst/foundry)

And you probably already have `make` installed... but if not [try looking here.](https://askubuntu.com/questions/161104/how-do-i-install-make)

## Getting Started / Quickstart

```sh
git clone https://github.com/brokewhale/soulbound-ERC20-token.git
cd soulbound-ERC20-token
$ curl -L https://foundry.paradigm.xyz | bash //this will install foundry


//follow the instruction after installation or open a new terminal and run
$ foundryup
```

## Testing

```
make test
```

or

```
forge test
```

# Deploying to a network

## Setup

You'll need the following:

- `RPC URL`: A URL to connect to the blockchain. You can get one for free from [Alchemy](https://www.alchemy.com/).
- `Private Key`: A private key from your wallet. You can get a private key from a new [Metamask](https://metamask.io/) account
  - Additionally, if you want to deploy to a testnet, you'll need test ETH and/or LINK. You can get them from [faucets.chain.link](https://faucets.chain.link/).
- `Constructor Arguments`: These are the arguments that you pass to your smart contract on deployment. If you look at the `constructor` function in each contract, those are the values that they need. If you want some examples, we've provided some in our `scripts/helper-config.sh` file.
- `Contract`: The name of the contract you want to deploy, ie `PriceFeedConsumer`.

## Deploying

```
$ forge create --rpc-url <your_rpc_url> --private-key <your_private_key> src/EXP.sol:EXP
compiling...
success.
Deployer: 0xa735b3c25f...
Deployed to: 0x4054415432...
Transaction hash: 0x6b4e0ff93a...

```

## Verifying

```
forge verify-contract --chain-id 80001 --num-of-optimizations 200 --compiler-version v0.8.13+commit.abaa5c0e <the_contract_address> src/EXP.sol:EXP <your_etherscan_api_key>


```

# Thank You!

## Resources

- [Foundry Documentation](https://onbjerg.github.io/foundry-book/)
