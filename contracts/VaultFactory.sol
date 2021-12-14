//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;

import { Vault } from "./Vault.sol";


/**
 * @dev - This is the smart contract for creating a new Vault
 */ 
contract VaultFactory {

    address[] public vaultAddresses;

    constructor() public {
        // [Todo]: 
    }

    function createVault() public returns (bool) {
        address issuer = msg.sender;

        Vault vault = new Vault(issuer);
        address VAULT = address(vault);
        vaultAddresses.push(VAULT);
    }

}
