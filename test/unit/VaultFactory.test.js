const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Unit test of the VaultFactory.sol", function () {

    //@dev - Deployed-contract instance
    let vaultFactory

    //@dev - Deployed-addresses
    let VAULT_FACTORY

    it("Deploy the VaultFactory.sol", async function () {
        const VaultFactory = await ethers.getContractFactory("VaultFactory")
        vaultFactory = await VaultFactory.deploy()
        VAULT_FACTORY = vaultFactory.address
        console.log(`Deployed-address of the VaultFactory.sol: ${ VAULT_FACTORY }`)
    })

    it("Should issue a new vault", async function () {
        // [Todo]:
    })

})
