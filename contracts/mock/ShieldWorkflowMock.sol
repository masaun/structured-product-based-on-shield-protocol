//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;

import { 
    ISLDContract, 
    IPrivatePool, 
    IPublicPool 
} from "../shield-contracts-v1-beta/SLDInterfaces.sol";


/**
 * @dev - This is the smart contract that is the workflow of the Shield Protocol
 */ 
contract ShieldWorkflowMock {

    ISLDContract public sldDAIContract;
    IPrivatePool public privateDAIPool;
    IPublicPool public publicDAIPool;


    /**
     * @dev - Each assigned-addresses are referenced from below: 
     *        https://docs.shieldex.io/trading-api-references/overview/smart-contracts-overview#bsc-testnet
     */ 
    constructor(
        ISLDContract _sldDAIContract,  // @dev - Assign the SLDDAIContract.sol deployed
        IPrivatePool _privateDAIPool,  // @dev - Assign the PrivateDAIPool.sol deployed 
        IPublicPool _publicDAIPool     // @dev - Assign the PublicDAIPool.sol deployed
    ) public {
        // [Todo]: 
    }


    function setSomething(string memory _something) public {}


    //------------------------------------
    // Getter methods
    //------------------------------------

    function getSomething() public view returns (string memory) {}


}
