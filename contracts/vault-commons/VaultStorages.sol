//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;


/**
 * @dev - This is the smart contract that deal with a Vault
 */ 
contract VaultStorages {

    struct VaultInfo {
        uint issuedAt;
        uint subscriptionPeriodAt;
        uint lockupPeriodAt;  // [NOTE]: Every time that a lock up period is updated, this value assigned is also updated
        uint windowPeriodAt;  // [NOTE]: Every time that a window period is updated, this value assigned is also updated
        uint maturedAt;
    }
    mapping (address => VaultInfo) vaultInfos;  // [Key]: issuer's address -> VaultInfo struct

}
