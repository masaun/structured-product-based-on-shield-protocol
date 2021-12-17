# Structured-product based on Shield Protocol
## 【Overview】
- This is the smart contract of structured products on the top of Shield Protocol that enable non-professional users to earn yield in a simple manner.

<br>

## 【Workflow】
- Workflow of this smart contract is following this document below that is created by the Shield Protocol  
  https://docs.google.com/document/d/1ESUCvi5gzarBbKjBsCwBLrzbHuQ4At1IhbYs6n0glIE/edit

<br>

## 【Technology stack】
- Solidity (Solc): v0.6.12
- Hardhat: v2.6.1
- ethers.js: v5.5.2
- Node.js: v16.7.0
- @openzeppelin/contracts: v3.4.0

etc...

<br>

## 【Installation】
- Install NPM modules
```
npm install
```

<br>

## 【Test】
- Unit test: `Vault.sol`
```
npm run test:Vault
```
( `$ npx hardhat test ./test/unit/Vault.test.js --network hardhat` )

<br>

- Unit test: `VaultFactory.sol`
```
npm run test:VaultFactory
```
( `$ npx hardhat test ./test/unit/VaultFactory.test.js --network hardhat` )

<br>

- Scenario test (※ NOTE: This scenario test has not implemented yet)
```
npm run test:Scenario
```
( `$ npx hardhat test ./test/scenario.test.js --network hardhat` )

<br>

## 【Demo Video】
- This demo video is that execute `unit tests` of the `Vault.sol` and `VaultFactory.sol` :  
  https://youtu.be/uH0hdGHwSFI

<br>

<hr>

## 【References】
- Shield Protocol
  - Website: https://shieldex.io 
  - Docs: https://docs.shieldex.io/ 
  - Lightpaper: https://docsend.com/view/fnsz5t5mj26qp8nh

<br>

- Shield Protocol (for implementation)  
  - Deployed-addresses: https://docs.shieldex.io/trading-api-references/overview/smart-contracts-overview#bsc-testnet  
  - Full ABI of Shield Protocol v1: https://docs.shieldex.io/trading-api-references/addendum/full-abi-on-shield-protocol-v1  

<br>

- Derivatives (Option) related protocols 
  - Opyn Protocol: https://www.opyn.co/
  - Ribbon.finance: https://app.ribbon.finance/

<br>

- 【GR12】Build structured product on top of Shield protocol  
   https://gitcoin.co/issue/shielddaodev/shield-bounties/1/100027177
