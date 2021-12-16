//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;

import { VaultEnums } from "./VaultEnums.sol";


/**
 * @dev - Storages (include Structs and mappiing, etc) that are used for the Vault-related smart contract
 */ 
contract VaultStorages is VaultEnums {

    mapping (address => VaultInfo) vaultInfos;  // [Key]: issuer's address -> VaultInfo struct

    struct VaultInfo {
        uint issuedAt;
        uint maturedAt;

        // 1) Customize the max capacity for each vault, with USDT as the default currency.
        uint targetRaisdAmount;
        uint maxCapacity;

        // 2) Customize the margin ratio and minimum margin
        uint marginRatio;
        uint minimumRatio;

        // 3) Set the duration of each phase, such as subscription, lockup, window, and investment period.
        uint subscriptionPeriodAt;
        uint investmentPeriodAt;
        uint lockupPeriodAt;  // [NOTE]: Every time that a lock up period is updated, this value assigned is also updated
        uint windowPeriodAt;  // [NOTE]: Every time that a window period is updated, this value assigned is also updated

        // 5) Vaults type:
        VaultType vaultType;  // [NOTE]: Assign value from the VaultType enum
    }

}
