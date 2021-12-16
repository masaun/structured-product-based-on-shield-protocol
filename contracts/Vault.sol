//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import { VaultStorages } from "./vault-commons/VaultStorages.sol";
import { VaultEvents } from "./vault-commons/VaultEvents.sol";


/**
 * @dev - This is the smart contract that deal with a Vault
 */ 
contract Vault is VaultStorages, VaultEvents {

    uint currentPerformance;   // APY(%) <- [Todo]: Implement a logic to assign current performance into this variable

    constructor(uint _vaultId, address _issuer, uint _issuedAt) public {
        VaultInfo storage vaultInfo = vaultInfos[_vaultId];
        vaultInfo.issuer = _issuer;
        vaultInfo.issuedAt = _issuedAt;
        vaultInfo.vaultStatus = VaultStatus.SUBSCRIPTION;
    }

    /**
     * @dev - Setting parameters of the vault. (Only issuer can call this method)
     */ 
    function settingVault(
        uint _vaultId,
        uint _maturedAt,
        uint _targetRaisdAmount,
        uint _maxCapacity,
        uint _marginRatio,
        uint _minimumRatio,
        uint _subscriptionPeriodAt,
        uint _investmentPeriodAt,
        uint _lockupPeriodAt,
        uint _windowPeriodAt,
        VaultType _vaultType
    ) public returns (bool) {
        address _issuer = msg.sender;

        VaultInfo storage vaultInfo = vaultInfos[_vaultId];
        vaultInfo.maturedAt = _maturedAt;
        vaultInfo.targetRaisedAmount = _targetRaisdAmount;
        vaultInfo.maxCapacity = _maxCapacity;
        vaultInfo.marginRatio = _marginRatio;
        vaultInfo.minimumRatio = _minimumRatio;
        vaultInfo.subscriptionPeriodAt = _subscriptionPeriodAt;
        vaultInfo.investmentPeriodAt = _investmentPeriodAt;
        vaultInfo.lockupPeriodAt = _lockupPeriodAt;
        vaultInfo.windowPeriodAt = _windowPeriodAt;
        vaultInfo.vaultType = _vaultType;

        emit VaultSet(_issuer,
                      _vaultId,
                      _maturedAt,
                      _targetRaisdAmount,
                      _maxCapacity,
                      _marginRatio,
                      _minimumRatio,
                      _subscriptionPeriodAt,
                      _investmentPeriodAt,
                      _lockupPeriodAt,
                      _windowPeriodAt,
                      _vaultType);
    }

    /**
     * @dev - A issuer deposit margin (after a new vault is issued)
     *
     * @dev - The margin ratio and minimum margin are customizable
     *        => Note of margin: the target raised amount is $1M, and 30% as margin ratio, the issuer needs to deposit $300K while the actual fund-raising amount is $700K.
     */ 
    function depositMargin(uint vaultId, IERC20 usdt) public returns (bool) {
        address issuer = msg.sender;
        
        VaultInfo memory vaultInfo = vaultInfos[vaultId];
        uint _targetRaisdAmount = vaultInfo.targetRaisedAmount;
        uint _marginRatio = vaultInfo.marginRatio;
    
        //@dev - A issuer deposit the margin amount based on the margin ratio
        _depositMargin(issuer, usdt, _targetRaisdAmount, _marginRatio);

        //@dev - Calculate the actual fund-raising amount
        uint fundRaisingAmount = _targetRaisdAmount * (100 - _marginRatio);
    }

    function _depositMargin(address issuer, IERC20 usdt, uint targetRaisedAmount, uint marginRatio) internal returns (bool) {
        //@dev - In advance, a caller (issuer) should approve their marginAmount of usdt.
        uint marginAmount = targetRaisedAmount * marginRatio;
        usdt.transferFrom(issuer, address(this), marginAmount);
    }


    ///------------------------------------
    /// Window period
    ///------------------------------------

    /**
     * @dev - Change the vault status to "Window Open"
     */ 
    function windowOpen(uint vaultId) public returns (bool) {
        address issuer = msg.sender;

        VaultInfo storage vaultInfo = vaultInfos[vaultId];
        vaultInfo.vaultStatus = VaultStatus.WINDOW;
    }

    /**
     * @dev - A user participate in a vault during the window period (fund-raising period)
     * @dev - A user deposit specified-amount of assets (USDT) into the vault
     */ 
    function depositAssets(uint vaultId, IERC20 usdt, uint depositAmount) public returns (bool) {
        //@dev - Check the vault status
        VaultInfo memory vaultInfo = vaultInfos[vaultId];
        VaultStatus _vaultStatus = vaultInfo.vaultStatus;
        require(_vaultStatus == VaultStatus.WINDOW, "Vault status should be 'Window'");

        //@dev - In advance, a caller (user) should approve their marginAmount of usdt.
        address user = msg.sender;
        usdt.transferFrom(user, address(this), depositAmount);
    }

    /**
     * @dev - A user withdraw specified-amount of assets (USDT) from the vault
     */ 
    function withdrawAssets(uint vaultId, IERC20 usdt) public returns (bool) {
        //@dev - Check the vault status
        VaultInfo memory vaultInfo = vaultInfos[vaultId];
        VaultStatus _vaultStatus = vaultInfo.vaultStatus;
        require(_vaultStatus == VaultStatus.WINDOW, "Vault status should be 'Window'");

        address user = msg.sender;

        // [Todo]: Assign proper value (amount) into each variable below
        uint principleAmount;
        uint profitsEarnedAmount = _harvestOrderTakingProfitsEarned();  // NOTE: Interest amount earned

        uint withdrawalAmount = principleAmount + profitsEarnedAmount;
        usdt.transfer(user, withdrawalAmount);
    }

    /**
     * @dev - Harvest order-taking profits earned
     */ 
    function _harvestOrderTakingProfitsEarned() internal returns (uint _profitsEarned) {
        address issuer = msg.sender;

        // [Todo]: Implement a logic for calculating profits earned.
        uint profitsEarned;
        return profitsEarned;
    }


    ///------------------------------------
    /// Lockup period
    ///------------------------------------

    /**
     * @dev - Fund locked in the Private Pool. (Change the vault status to "Lockup fund")
     */ 
    function fundlocked(uint vaultId) public returns (bool) {
        address issuer = msg.sender;

        VaultInfo storage vaultInfo = vaultInfos[vaultId];
        vaultInfo.vaultStatus = VaultStatus.LOCKUP;
    }


    ///------------------------------------
    /// Matured (This vault is matured)
    ///------------------------------------

    /**
     * @dev - Vault is matured (due date)
     */ 
    function vaultIsMatured(uint vaultId) public returns (bool) {
        address issuer = msg.sender;
        VaultInfo storage vaultInfo = vaultInfos[vaultId];
        vaultInfo.vaultStatus = VaultStatus.MATURED;
    }


    /**
     * @dev - Vault is at ADL
     */ 
    function vaultIsADL(uint vaultId) public returns (bool) {
        address issuer = msg.sender;
        VaultInfo storage vaultInfo = vaultInfos[vaultId];
        vaultInfo.vaultStatus = VaultStatus.ADL;
    }


    ///------------------------------------
    /// Check the vault information
    ///------------------------------------

    /**
     * @dev - Get stored-data of vault from the VaultInfo struct
     */ 
    function getVaultInfo(uint vaultId) public view returns (VaultInfo memory _vaultInfo) {
        VaultInfo memory vaultInfo = vaultInfos[vaultId];
        return vaultInfo;
    }



    ///------------------------------------
    /// Check the stats of this vault
    ///------------------------------------

    /**
     * @dev - Current performance (APY) of this vault
     */ 
    function getCurrentPerformance() public view returns (uint _currentPerformance) {
        return currentPerformance;
    }

}
