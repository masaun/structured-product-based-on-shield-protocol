//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;

import { 
    ISLDContract, 
    IPrivatePool, 
    IPublicPool 
} from "./shield-contracts-v1-beta/SLDInterfaces.sol";


/**
 * @dev - This is the smart contract that deal with a structured-product based on the Shield Protocol
 */ 
contract StructuredProduct {

    ISLDContract public sldDAIContract;
    IPrivatePool public privateDAIPool;
    IPublicPool public publicDAIPool;

    constructor(
        ISLDContract _sldDAIContract, 
        IPrivatePool _privateDAIPool, 
        IPublicPool _publicDAIPool
    ) public {
        // [Todo]: 
    }


    function setSomething(string memory _something) public {}


    //------------------------------------
    // Getter methods
    //------------------------------------

    function getSomething() public view returns (string memory) {}


}
