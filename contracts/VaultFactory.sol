//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import { Vault } from "./Vault.sol";
import { VaultStorages } from "./vault-commons/VaultStorages.sol";
import { VaultEvents } from "./vault-commons/VaultEvents.sol";


/**
 * @dev - This is the smart contract for creating a new Vault
 */ 
contract VaultFactory is VaultEvents {

    uint currentVaultId;  // [NOTE]: Vault ID is counted from "0"

    address[] public vaultAddresses;

    constructor() public {
        // [Todo]: 
    }

    /**
     * @dev - A issuer issue a new vault
     */ 
    function issueVault() public returns (bool) {
        uint newVaultId = currentVaultId;
        address issuer = msg.sender;
        uint issuedAt = block.timestamp;

        //@dev - Issue a new vault
        Vault vault = new Vault(newVaultId, issuer, issuedAt);
        address VAULT = address(vault);
        vaultAddresses.push(VAULT);

        //@dev - Update current Vault ID
        currentVaultId++;

        emit VaultCreated(issuer, VAULT);
    }

}
