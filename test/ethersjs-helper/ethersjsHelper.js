const { expect } = require("chai")
const { ethers } = require("hardhat")

function toWei(amount) {
    return ethers.utils.parseEther(`${ amount }`)
}

function fromWei(amount) {
    return ethers.utils.formatEther(`${ amount }`)
}

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

async function getCurrentBlock() {}

async function getCurrentTimestamp() {}

/// Export methods
module.exports = { toWei, fromWei, getEventLog }
