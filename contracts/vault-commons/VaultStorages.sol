//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;


/**
 * @dev - This is the smart contract that deal with a Vault
 */ 
contract VaultStorages {

    mapping (address => VaultInfo) vaultInfos;  // [Key]: issuer's address -> VaultInfo struct

    struct VaultInfo {
        uint issuedAt;
        uint subscriptionPeriodAt;
        uint lockupPeriodAt;  // [NOTE]: Every time that a lock up period is updated, this value assigned is also updated
        uint windowPeriodAt;  // [NOTE]: Every time that a window period is updated, this value assigned is also updated
        uint maturedAt;
    }


    /**
     * @dev - Vaults type:
     *  a. 100% capital protected at maturity with an interest guarantee, customize the margin and APY
     *  b. 100% capital protected at maturity without interest guarantee, customize the margin and APY is 0
     *  c. non capital protected at maturity with limited loss, customize max loss ratio
     *  d. non capital protected at maturity without max loss, customize 100% loss percentage
     */
    enum VaultType { 
        HUNDRED_PERCENT_CAPITAL_PROTECTED_AT_MATURITY_WITH_AN_INTEREST_GUARANTEE,
        HUNDRED_PERCENT_CAPITAL_PROTECTED_AT_MATURITY_WITHOUT_AN_INTEREST_GUARANTEE,
        NON_CAPITAL_PROTECTED_AT_MATURITY_WITH_LIMITED_LOSS,
        NON_CAPITAL_PROTECTED_AT_MATURITY_WITHOUT_MAX_LOSS
    }

}
