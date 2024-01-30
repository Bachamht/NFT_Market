// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

abstract contract BaseScript is Script {
    address internal admin;
    uint256 internal privateKEY;

    function setUp() public virtual {
        privateKEY = vm.envUint("PRIVATE_KEY");
        admin = vm.rememberKey(privateKEY);
    }

}