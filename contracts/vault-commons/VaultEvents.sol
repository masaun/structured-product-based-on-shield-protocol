//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;

import { VaultEnums } from "./VaultEnums.sol";


/**
 * @dev - Events that are used for the Vault-related smart contract
 */ 
contract VaultEvents is VaultEnums {

    event VaultCreated(
        address issuer, 
        address vault   // Address of a new vault created
    );

    event VaultSet(
        address issuer,
        uint vaultId,
        uint maturedAt,
        uint targetRaisedAmount,
        uint maxCapacity,
        uint marginRatio,
        uint minimumRatio,
        uint subscriptionPeriodAt,
        uint investmentPeriodAt,
        uint lockupPeriodAt,
        uint windowPeriodAt,
        VaultType vaultType
    );

}
