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
- Unit test: `Vault.sol`
```
npm run test:Vault
```

- Unit test: `VaultFactory.sol`
```
npm run test:VaultFactory
```

<br>

- Scenario test (※ This has not implemented yet)
```
npm run test:Scenario
```
( `$ npx hardhat test ./test/scenario.test.js --network hardhat` )

<br>

## 【Demo Video】
- This demo video is that execute unit tests of the Vault.sol and VaultFactory.sol:  
  https://youtu.be/uH0hdGHwSFI

<br>
