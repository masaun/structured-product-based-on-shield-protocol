//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import { VaultStorages } from "./vault-commons/VaultStorages.sol";


/**
 * @dev - This is the smart contract that deal with a Vault
 */ 
contract Vault is VaultStorages {

    constructor(address _issuer, uint _issuedAt) public {
        VaultInfo storage vaultInfo = vaultInfos[_issuer];
        vaultInfo.issuedAt = _issuedAt;
        vaultInfo.vaultStatus = VaultStatus.SUBSCRIPTION;
    }

    /**
     * @dev - Setting parameters of the vault. (Only issuer can call this method)
     */ 
    function settingVault(
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

        VaultInfo storage vaultInfo = vaultInfos[_issuer];
        vaultInfo.maturedAt = _maturedAt;
        vaultInfo.targetRaisdAmount = _targetRaisdAmount;
        vaultInfo.maxCapacity = _maxCapacity;
        vaultInfo.marginRatio = _marginRatio;
        vaultInfo.minimumRatio = _minimumRatio;
        vaultInfo.subscriptionPeriodAt = _subscriptionPeriodAt;
        vaultInfo.investmentPeriodAt = _investmentPeriodAt;
        vaultInfo.lockupPeriodAt = _lockupPeriodAt;
        vaultInfo.windowPeriodAt = _windowPeriodAt;
        vaultInfo.vaultType = _vaultType;
    }

    /**
     * @dev - A issuer deposit margin (after a new vault is issued)
     *
     * @dev - The margin ratio and minimum margin are customizable
     *        => Note of margin: the target raised amount is $1M, and 30% as margin ratio, the issuer needs to deposit $300K while the actual fund-raising amount is $700K.
     */ 
    function depositMargin(IERC20 usdt) public returns (bool) {
        address issuer = msg.sender;
        
        VaultInfo memory vaultInfo = vaultInfos[issuer];
        uint _targetRaisdAmount = vaultInfo.targetRaisdAmount;
        uint _marginRatio = vaultInfo.marginRatio;
    
        //@dev - A issuer deposit the margin amount based on the margin ratio
        _depositMargin(issuer, usdt, _targetRaisdAmount, _marginRatio);

        //@dev - Calculate the actual fund-raising amount
        uint fundRaisingAmount = _targetRaisdAmount * (100 - _marginRatio);
    }

    function _depositMargin(address issuer, IERC20 usdt, uint targetRaisdAmount, uint marginRatio) internal returns (bool) {
        //@dev - In advance, a caller (issuer) should approve their marginAmount of usdt.
        uint marginAmount = targetRaisdAmount * marginRatio;
        usdt.transferFrom(issuer, address(this), marginAmount);
    }


    ///------------------------------------
    /// Window period
    ///------------------------------------

    /**
     * @dev - Change the vault status to "Window Open"
     */ 
    function windowOpen() public returns (bool) {
        address issuer = msg.sender;

        VaultInfo storage vaultInfo = vaultInfos[issuer];
        vaultInfo.vaultStatus = VaultStatus.WINDOW;
    }

    /**
     * @dev - A user participate in a vault during the window period (fund-raising period)
     * @dev - A user deposit specified-amount of assets (USDT) into the vault
     */ 
    function depositAssets(address issuer, IERC20 usdt, uint depositAmount) public returns (bool) {
        //@dev - Check the vault status
        VaultInfo memory vaultInfo = vaultInfos[issuer];
        VaultStatus _vaultStatus = vaultInfo.vaultStatus;
        require(_vaultStatus == VaultStatus.WINDOW, "Vault status should be 'Window'");

        //@dev - In advance, a caller (user) should approve their marginAmount of usdt.
        address user = msg.sender;
        usdt.transferFrom(user, address(this), depositAmount);
    }

    /**
     * @dev - A user withdraw specified-amount of assets (USDT) from the vault
     */ 
    function withdrawAssets(address issuer, IERC20 usdt) public returns (bool) {
        //@dev - Check the vault status
        VaultInfo memory vaultInfo = vaultInfos[issuer];
        VaultStatus _vaultStatus = vaultInfo.vaultStatus;
        require(_vaultStatus == VaultStatus.WINDOW, "Vault status should be 'Window'");

        address user = msg.sender;

        // [Todo]: Assign proper value (amount) into each variable below
        uint principleAmount;
        uint interestAmount;   // NOTE: Interest amount earned

        uint withdrawalAmount = principleAmount + interestAmount;
        usdt.transfer(user, withdrawalAmount);
    }



    ///------------------------------------
    /// Lockup period
    ///------------------------------------

    /**
     * @dev - Fund locked in the Private Pool. (Change the vault status to "Lockup fund")
     */ 
    function fundlocked() public returns (bool) {
        address issuer = msg.sender;

        VaultInfo storage vaultInfo = vaultInfos[issuer];
        vaultInfo.vaultStatus = VaultStatus.LOCKUP;
    }

    /**
     * @dev - Earn order-taking profits (Harvest profits)
     */ 
    function earningOrderTakingProfits() public returns (bool) {
        // [Todo]: 
        address issuer = msg.sender;
    }


    ///------------------------------------
    /// Due (This vault is matured)
    ///------------------------------------

    /**
     * @dev - Vault due/ADL
     */ 
    function vaultDueADL() public returns (bool) {
        address issuer = msg.sender;
        VaultInfo storage vaultInfo = vaultInfos[issuer];
        vaultInfo.vaultStatus = VaultStatus.DUE;
    }

}
