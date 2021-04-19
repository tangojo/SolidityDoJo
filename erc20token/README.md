# Standard ERC20 Token  
"Token" is a standard openzeppelin ERC Token implementaion in in Solidity 0.8.3 for BSC testnet.

# Steps
1. Initial setup inside the project folder
```
truffle init .
npm init -y
npm install @truffle/hdwallet-provider
npm install @openzeppelin/contracts@4.0.0
```
2. Edit truffle-config.js
2.1. Compiler version `version: "0.8.3"`
2.2. Configure `BSCtestnet`
2.3. Configure `hdwallet-provider`

3. Code smart contract
Compile with `truffle compile`

3. Deploy contract 
All scripts with `truffle migrate --reset --network BSCtestnet`
Single script with `truffle exec migrations/2_deploy_contract.js --network BSCtestnet`