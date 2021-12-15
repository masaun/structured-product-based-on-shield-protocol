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

    /**
     * @dev - A issuer deposit margin (after a new vault is issued)
     *
     * @dev - The margin ratio and minimum margin are customizable
     *        => Note of margin: the target raised amount is $1M, and 30% as margin ratio, the issuer needs to deposit $300K while the actual fund-raising amount is $700K.
     */ 
    function depositMargin() public returns (bool) {
        address issuer = msg.sender;
        
        VaultInfo memory vaultInfo = vaultInfos[issuer];
        uint _marginRatio = vaultInfo.marginRatio;
    
        //@dev - Calculate the actual fund-raising amount
        uint targetRaisdAmount;  // [TODO]: Need to add a property of target raised amount to the VaultInfo struct
        uint fundRaisingAmount = targetRaisdAmount * (100 - _marginRatio);
    }

    /**
     * @dev - Fund locked in the Private Pool
     */ 
    function fundlocked() public returns (bool) {
        // [Todo]: 
        address issuer = msg.sender;
    }

    /**
     * @dev - Start earning order-taking profits
     */ 
    function startEarningOrderTakingProfits() public returns (bool) {
        // [Todo]: 
        address issuer = msg.sender;
    }

    /**
     * @dev - Vault due/ADL
     */ 
    function vaultDueADL() public returns (bool) {
        // [Todo]: 
        address issuer = msg.sender;
    }

}
