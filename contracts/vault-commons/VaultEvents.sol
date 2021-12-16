//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;


/**
 * @dev - Events that are used for the Vault-related smart contract
 */ 
contract VaultEvents {

    event VaultCreated(
        address issuer, 
        address vault   // Address of a new vault created
    );

}
