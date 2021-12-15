//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;

import { VaultStorages } from "./vault-commons/VaultStorages.sol";


/**
 * @dev - This is the smart contract that deal with a Vault
 */ 
contract Vault is VaultStorages {

    constructor(
        address _issuer,
        uint _issuedAt,
        uint _maturedAt,
        uint _maxCapacity,
        uint _marginRatio,
        uint _minimumRatio,
        uint _subscriptionPeriodAt,
        uint _lockupPeriodAt,
        uint _windowPeriodAt,
        VaultType _vaultType
    ) public {
        VaultInfo storage vaultInfo = vaultInfos[_issuer];
        vaultInfo.issuedAt = _issuedAt;
        vaultInfo.maturedAt = _maturedAt;
        vaultInfo.maxCapacity = _maxCapacity;
        vaultInfo.marginRatio = _marginRatio;
        vaultInfo.minimumRatio = _minimumRatio;
        vaultInfo.subscriptionPeriodAt = _subscriptionPeriodAt;
        vaultInfo.lockupPeriodAt = _lockupPeriodAt;
        vaultInfo.windowPeriodAt = _windowPeriodAt;
        vaultInfo.vaultType = _vaultType;
    }

    /**
     * @dev - A user participate in a vault
     * @dev - A user deposit specified-amount of assets (tokens) into the vault
     */ 
    function depositAssets(uint depositAmount) public returns (bool) {
        // [Todo]: 
        address user = msg.sender;
    }

    /**
     * @dev - A user withdraw specified-amount of assets (tokens) from the vault
     */ 
    function withdrawAssets(uint withdrawalAmount) public returns (bool) {
        // [Todo]: 
        address user = msg.sender;
    }


}
