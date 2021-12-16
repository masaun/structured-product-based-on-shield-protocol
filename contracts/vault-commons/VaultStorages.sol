//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;

import { VaultEnums } from "./VaultEnums.sol";


/**
 * @dev - Storages (include Structs and mappiing, etc) that are used for the Vault-related smart contract
 */ 
contract VaultStorages is VaultEnums {

    mapping (uint => VaultInfo) vaultInfos;  // [Key]: Vault ID -> VaultInfo struct

    struct VaultInfo {
        address issuer;
        uint issuedAt;
        uint maturedAt;  // [NOTE]: Probably, this is same with "investmentPeriodAt"

        // 1) Customize the max capacity for each vault, with USDT as the default currency.
        uint targetRaisedAmount;
        uint maxCapacity;

        // 2) Customize the margin ratio and minimum margin
        uint marginRatio;
        uint minimumRatio;

        // 3) Set the duration of each phase, such as subscription, lockup, window, and investment period.
        uint subscriptionPeriodAt;
        uint investmentPeriodAt;    // [NOTE]: Probably, this is same with "maturedAt"
        uint lockupPeriodAt;  // [NOTE]: Every time that a lock up period is updated, this value assigned is also updated
        uint windowPeriodAt;  // [NOTE]: Every time that a window period is updated, this value assigned is also updated

        // 5) Vaults type:
        VaultType vaultType;     // [NOTE]: Assign value from the VaultType enum

        //@dev - This is whether the vault is locked (locked period) or not
        VaultStatus vaultStatus;  // [NOTE]: Assign value from the VaultStatus enum
    }

}
