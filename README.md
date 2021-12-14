# Structured-product based on Shield Protocol
- 【GR12🌍】Build "structured product" (=Combining assets) on top of Shield Protocol🛡 on BSC：   
https://gitcoin.co/issue/shielddaodev/shield-bounties/1/100027177

<br>

## 【Deployment】
- Deployment on local network
```
npm run deploy-local:StructuredProduct
```
( `$ npx hardhat run scripts/deployment/00_deploy_StructuredProduct.js --network hardhat` )

<br>

- Deployment on BSC testnet
```
npm run deploy-bsc_testnet:StructuredProduct
```
( `$ npx hardhat run scripts/deployment/00_deploy_StructuredProduct.js --network bsc_testnet` )


<br>

## 【Test】
```
npm run test:Scenario
```
( `$ npx hardhat test ./test/scenario.test.js --network hardhat` )

<br>



<hr>

# Basic Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```
