const { ethers } = require("hardhat")


/**
 * @dev - This is a deployment file for the ShieldWorkflowMock.sol
 * Network: BSC testnet
 */
async function main() {

    const _sldDAIContract = "0x7125E80fF9c5ae3073bf30769d0963B6d0B57515"  // @dev - Assign the SLDDAIContract.sol deployed
    const _privateDAIPool = "0xaDea523A790b34CF6D0989a803262b2A38FD7cdA"  // @dev - Assign the PrivateDAIPool.sol deployed 
    const _publicDAIPool = "0xb3F55De3a56F15d6C94cF74753F52e447519E563"   // @dev - Assign the PublicDAIPool.sol deployed

    const ShieldWorkflowMock = await ethers.getContractFactory("ShieldWorkflowMock")
    const shieldWorkflowMock = await ShieldWorkflowMock.deploy(_sldDAIContract, _privateDAIPool, _publicDAIPool)
    console.log("ShieldWorkflowMock deployed to:", shieldWorkflowMock.address)
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error)
      process.exit(1)
    })
