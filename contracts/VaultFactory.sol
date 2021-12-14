//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;

import { Vault } from "./Vault.sol";


/**
 * @dev - This is the smart contract for creating a new Vault
 */ 
contract VaultFactory {

    Vault public vault;

    constructor(Vault _vault) public {
        vault = _vault;
    }

    function setSomething() public returns (bool) {
        // [Todo]: 
    }

}
