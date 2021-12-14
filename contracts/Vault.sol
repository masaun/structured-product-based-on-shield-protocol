//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;


/**
 * @dev - This is the smart contract that deal with a Vault
 */ 
contract Vault {

    struct VaultInfo {
        // [Todo]:
        uint issuedAt;
        uint maturedAt;
    }
    mapping (address => VaultInfo) vaultInfos;  // [Key]: issuer's address -> VaultInfo struct

    constructor(address issuer) public {
        // [Todo]: 
        VaultInfo storage vaultInfo = vaultInfos[issuer];
        vaultInfo.issuedAt = block.timestamp;
        vaultInfo.maturedAt = 0;
    
    }

    /**
     * @dev - A user participate in a vault
     */ 
    function participateInVault() public returns (bool) {
        // [Todo]: 
        address user = msg.sender;
    }

}
