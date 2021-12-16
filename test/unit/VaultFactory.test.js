const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Unit test of the VaultFactory.sol", function () {

    //@dev - Signer of each accounts
    let signerOfIssuer
    let signerOfUser

    //@dev - Deployed-contract instance
    let vaultFactory

    //@dev - Deployed-addresses
    let VAULT_FACTORY

    //@dev - Method for retrieving an event log that is associated with "eventName" specified
    async function getEventLog(txReceipt, eventName) {
        for (let i = 0; i < txReceipt.events.length; i++) {
            const eventLogs = txReceipt.events[i];
            console.log(`eventLogs: ${ JSON.stringify(eventLogs, null, 2) }`)

            if (eventLogs["event"] == eventName) {
                const _args = eventLogs["args"]
                return _args  // [NOTE] Return event log specified as array
            }
        }
    }

    it("Get signatures of each accounts", async function () {
        [signerOfIssuer, signerOfUser] = await ethers.getSigners()
        console.log(`Signer of a issuer: ${ JSON.stringify(signerOfIssuer) }`)
        console.log(`Signer of a user: ${ JSON.stringify(signerOfUser) }`)
    })

    it("Deploy the VaultFactory.sol", async function () {
        const VaultFactory = await ethers.getContractFactory("VaultFactory")
        vaultFactory = await VaultFactory.deploy()
        VAULT_FACTORY = vaultFactory.address
        console.log(`Deployed-address of the VaultFactory.sol: ${ VAULT_FACTORY }`)

        expect(VAULT_FACTORY).to.equal(vaultFactory.address);
    })

    it("Should issue a new vault", async function () {
        const transaction = await vaultFactory.connect(signerOfIssuer).issueVault()
        const txReceipt = await transaction.wait()
        //const _txReceipt = JSON.stringify(txReceipt, null, 2)

        //@dev - Check event log of "VaultCreated"
        const EVENT_NAME = "VaultCreated"
        const eventLog = await getEventLog(txReceipt, EVENT_NAME)
        console.log(`event log of "VaultCreated": ${ eventLog }`)

        const ISSUER = eventLog[0]
        const VAULT_CREATED = eventLog[1]
        console.log(`"issuer" that is retrieved from event log of "VaultCreated": ${ ISSUER }`)
        console.log(`"vault address" that is retrieved from event log of "VaultCreated": ${ VAULT_CREATED }`)

        expect(ISSUER).to.equal(signerOfIssuer.address);
    })

})
