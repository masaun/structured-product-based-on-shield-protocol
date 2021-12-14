//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;

import { VaultStorages } from "./vault-commons/VaultStorages.sol";


/**
 * @dev - This is the smart contract that deal with a Vault
 */ 
contract Vault is VaultStorages {

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
