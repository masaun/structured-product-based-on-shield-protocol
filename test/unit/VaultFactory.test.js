const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Unit test of the VaultFactory.sol", function () {

    //@dev - Sign of each accounts
    let issuerSign
    let userSign

    //@dev - Deployed-contract instance
    let vaultFactory

    //@dev - Deployed-addresses
    let VAULT_FACTORY

    it("Get signatures of each accounts", async function () {
        [issuerSign, userSign] = await ethers.getSigners()
        console.log(`Signature of a issuer: ${ JSON.stringify(issuerSign) }`)
        console.log(`Signature of a user: ${ JSON.stringify(userSign) }`)
    })

    it("Deploy the VaultFactory.sol", async function () {
        const VaultFactory = await ethers.getContractFactory("VaultFactory")
        vaultFactory = await VaultFactory.deploy()
        VAULT_FACTORY = vaultFactory.address
        console.log(`Deployed-address of the VaultFactory.sol: ${ VAULT_FACTORY }`)

        expect(VAULT_FACTORY).to.equal(vaultFactory.address);
    })

    it("Should issue a new vault", async function () {
        const transaction = await vaultFactory.connect(issuerSign).issueVault()
        const txReceipt = transaction.wait()
    })

})
