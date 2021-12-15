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
    function issueVault(
        uint maturedAt,
        uint targetRaisdAmount,
        uint maxCapacity,
        uint marginRatio,
        uint minimumRatio,
        uint subscriptionPeriodAt,
        uint lockupPeriodAt,
        uint windowPeriodAt,
        VaultStorages.VaultType vaultType  // [NOTE]: Value referenced from the VaultType enum is assigned  
    ) public returns (bool) {
        address issuer = msg.sender;
        uint issuedAt = block.timestamp;

        //@dev - Issue a new vault
        Vault vault = new Vault(issuer, 
                                issuedAt,
                                maturedAt,
                                targetRaisdAmount,
                                maxCapacity,
                                marginRatio,
                                minimumRatio,
                                subscriptionPeriodAt,
                                lockupPeriodAt,
                                windowPeriodAt,
                                vaultType);
        address VAULT = address(vault);
        vaultAddresses.push(VAULT);
    }

}
