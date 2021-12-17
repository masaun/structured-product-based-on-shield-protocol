//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";


/**
 * @dev - This is the mock token of USDT
 */ 
contract USDTMockToken is ERC20 {

    string NAME = "Tether USD - Mock Token";
    string SYMBOL = "USDT";
    uint8 DECIMALS = 6;

    constructor() public ERC20(NAME, SYMBOL) {
        _setupDecimals(DECIMALS);
    }

    function mintUSDT(address to, uint amount) public returns (bool) {
        _mint(to, amount);
    }

}
