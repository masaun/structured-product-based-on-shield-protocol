//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;


/**
 * @dev - This is the smart contract that deal with a Vault
 */ 
contract Vault {

    struct VaultInfo {
        uint issuedAt;
        uint subscriptionPeriodAt;
        uint lockupPeriodAt;  // [NOTE]: Every time that a lock up period is updated, this value assigned is also updated
        uint windowPeriodAt;  // [NOTE]: Every time that a window period is updated, this value assigned is also updated
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
     * @dev - A user deposit some amount of tokens into the vault
     */ 
    function depositIntoVault(uint depositAmount) public returns (bool) {
        // [Todo]: 
        address user = msg.sender;
    }

    /**
     * @dev - A user withdraw specified-amount of tokens from the vault
     */ 
    function withdrawFromVault(uint withdrawalAmount) public returns (bool) {
        // [Todo]: 
        address user = msg.sender;
    }


}
