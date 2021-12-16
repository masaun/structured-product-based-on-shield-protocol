//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;

import { Vault } from "./Vault.sol";
import { VaultStorages } from "./vault-commons/VaultStorages.sol";


/**
 * @dev - This is the smart contract for creating a new Vault
 */ 
contract VaultFactory {

    address[] public vaultAddresses;

    constructor() public {
        // [Todo]: 
    }

    /**
     * @dev - A issuer issue a new vault
     */ 
    function issueVault() public returns (bool) {
        address issuer = msg.sender;
        uint issuedAt = block.timestamp;

        //@dev - Issue a new vault
        Vault vault = new Vault(issuer, issuedAt);
        address VAULT = address(vault);
        vaultAddresses.push(VAULT);
    }

}
