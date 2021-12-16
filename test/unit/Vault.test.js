const { expect } = require("chai")
const { ethers } = require("hardhat")

//@dev - ethers.js related methods
const { convertHexToString, convertStringToHex, toWei, fromWei, getEventLog, getCurrentBlock, getCurrentTimestamp } = require('../ethersjs-helper/ethersjsHelper')


describe("Unit test of the Vault.sol", function () {

    //@dev - Signer of each accounts
    let signerOfIssuer
    let signerOfUser

    //@dev - Deployed-contract instance
    let vaultFactory
    let vault1
    let vault2
    let vault3

    //@dev - Deployed-addresses
    let VAULT_FACTORY
    let VAULT_1
    let VAULT_2
    let VAULT_3

    //@dev - Time
    const A_HOUR = 60 * 60
    const A_DAY = 60 * 60 * 24

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

        //@dev - Check
        expect(ISSUER).to.equal(signerOfIssuer.address)

        //@dev - Assign a new vault created into variable of Vault No.1
        VAULT_1 = VAULT_CREATED
        console.log(`Vault No.1:  ${ VAULT_1  }`)

        //@dev - Create the instance of the vault No.1
        vault1 = await ethers.getContractAt("Vault", VAULT_1)
    })


    ///--------------------------------------------------------
    /// Testing of the Vault.sol related methods from below
    ///--------------------------------------------------------

    it("settingVault() - A issuer set parameters of the vault", async function () {
        const currentUnixTimestamp = Math.floor(new Date / 1000)
        console.log(`current Unix timestamp: ${ currentUnixTimestamp }`)

        const vaultId = 0
        const maturedAt = currentUnixTimestamp + (A_DAY * 10)            // 10 days
        const targetRaisedAmount = toWei('1000000')                       // 1000000 USDT
        const maxCapacity = toWei('1500000')                             // 1500000 USDT
        const marginRatio = String(3 * 1e17)                             // 30 % 
        const minimumRatio = String(1 * 1e17)                            // 10 % 
        const subscriptionPeriodAt = currentUnixTimestamp + (A_DAY * 2)  // 2 days
        const investmentPeriodAt = currentUnixTimestamp + (A_DAY * 10)   // 10 days
        const lockupPeriodAt = currentUnixTimestamp + (A_DAY * 3)        // 3 days
        const windowPeriodAt = currentUnixTimestamp + (A_DAY * 1)        // 1 days
        const vaultType = 0  // [NOTE]: This (vaultType = 0) mean that "100% capital protected at maturity with an interest guarantee, customize the margin and APY"

        //@dev - Set parameters of the vault
        let transaction = await vault1.settingVault(vaultId,
                                                    maturedAt,
                                                    targetRaisedAmount,
                                                    maxCapacity,
                                                    marginRatio,
                                                    minimumRatio,
                                                    subscriptionPeriodAt,
                                                    investmentPeriodAt,
                                                    lockupPeriodAt,
                                                    windowPeriodAt,
                                                    vaultType)
        let txReceipt = await transaction.wait()

        //@dev - Check event log of "VaultSet"
        const EVENT_NAME = "VaultSet"
        const eventLog = await getEventLog(txReceipt, EVENT_NAME)
        console.log(`event log of "VaultSet": ${ eventLog }`)

        const ISSUER = eventLog[0]
        const VAULT_ID = eventLog[1]
        const MATURED_AT = eventLog[2]
        const TARGET_RAISED_AMOUNT = eventLog[3]
        const MAX_CAPACITY = eventLog[4]
        const MARGIN_RATIO = eventLog[5]
        const MINIMUM_RATIO = eventLog[6]
        const SUBSCRIPTION_PERIOD_AT = eventLog[7]
        const INVESTMENT_PERIOD_AT = eventLog[8]
        const LOCKUP_PERIOD_AT = eventLog[9]
        const WINDOW_PERIOD_AT = eventLog[10]
        const VAULT_TYPE = eventLog[11]
        console.log(`"issuer" that is retrieved from event log of "VaultSet": ${ ISSUER }`)
        console.log(`"vaultId" that is retrieved from event log of "VaultSet": ${ VAULT_ID }`)
        console.log(`"maturedAt" that is retrieved from event log of "VaultSet": ${ MATURED_AT }`)
        console.log(`"targetRaisedAmount" that is retrieved from event log of "VaultSet": ${ TARGET_RAISED_AMOUNT }`)
        console.log(`"maxCapacity" that is retrieved from event log of "VaultSet": ${ MAX_CAPACITY }`)
        console.log(`"marginRatio" that is retrieved from event log of "VaultSet": ${ MARGIN_RATIO }`)
        console.log(`"minimumRatio" that is retrieved from event log of "VaultSet": ${ MINIMUM_RATIO }`)
        console.log(`"subscriptionPeriodAt" that is retrieved from event log of "VaultSet": ${ SUBSCRIPTION_PERIOD_AT }`)
        console.log(`"investmentPeriodAt" that is retrieved from event log of "VaultSet": ${ INVESTMENT_PERIOD_AT }`)
        console.log(`"lockupPeriodAt" that is retrieved from event log of "VaultSet": ${ LOCKUP_PERIOD_AT }`)
        console.log(`"windowPeriodAt" that is retrieved from event log of "VaultSet": ${ WINDOW_PERIOD_AT }`)
        console.log(`"vaultType" that is retrieved from event log of "VaultSet": ${ VAULT_TYPE }`)

        //@dev - Check
        expect(ISSUER).to.equal(signerOfIssuer.address)
        expect(VAULT_ID).to.equal(vaultId)
        expect(MATURED_AT).to.equal(maturedAt)
        expect(TARGET_RAISED_AMOUNT).to.equal(targetRaisedAmount)
        expect(MAX_CAPACITY).to.equal(maxCapacity)
        expect(MARGIN_RATIO).to.equal(marginRatio)
        expect(MINIMUM_RATIO).to.equal(minimumRatio)
        expect(SUBSCRIPTION_PERIOD_AT).to.equal(subscriptionPeriodAt)
        expect(INVESTMENT_PERIOD_AT).to.equal(investmentPeriodAt)
        expect(LOCKUP_PERIOD_AT).to.equal(lockupPeriodAt)
        expect(WINDOW_PERIOD_AT).to.equal(windowPeriodAt)
        expect(VAULT_TYPE).to.equal(vaultType)
    })

    it("depositMargin() - A issuer deposit margin", async function () {
        // [Todo]: 
    })

    it("windowOpen() - Window period is opened", async function () {
        // [Todo]: 
    })

    it("depositAssets() - A user deposit assets (USDT)", async function () {
        // [Todo]: 
    })

    it("fundlocked() - Lockup period is started and funds are locked", async function () {
        // [Todo]: 
    })

    it("withdrawAssets() - A user withdraw their principle and profits", async function () {
        // [Todo]: 
    })

    it("vaultIsMatured() - Investment period of the vault is expired (matured)", async function () {
        // [Todo]: 
    })

})
