//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import { VaultStorages } from "./vault-commons/VaultStorages.sol";


/**
 * @dev - This is the smart contract that deal with a Vault
 */ 
contract Vault is VaultStorages {

    constructor(
        address _issuer,
        uint _issuedAt,
        uint _maturedAt,
        uint _targetRaisdAmount,
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
        vaultInfo.targetRaisdAmount = _targetRaisdAmount;
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
    function depositAssets(IERC20 usdt, uint depositAmount) public returns (bool) {
        //@dev - In advance, a caller (user) should approve their marginAmount of usdt.
        address user = msg.sender;
        usdt.transferFrom(user, address(this), depositAmount);
    }

    /**
     * @dev - A user withdraw specified-amount of assets (tokens) from the vault
     */ 
    function withdrawAssets(IERC20 usdt) public returns (bool) {
        address user = msg.sender;

        // [Todo]: Assign proper value (amount) into each variable below
        uint principleAmount;
        uint interestAmount;   // NOTE: Interest amount earned

        uint withdrawalAmount = principleAmount + interestAmount;
        usdt.transfer(user, withdrawalAmount);
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
