//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;


/**
 * @dev - Enums that are used for the Vault-related smart contract
 */ 
contract VaultEnums {

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

    /**
     * @dev - Status of the vaule. (Subscription period / Window period / Locked period / Due)
     */ 
    enum VaultStatus { SUBSCRIPTION, WINDOW, LOCKED, DUE }  // [NOTE]: "Due" is same mean with "matured"

}
