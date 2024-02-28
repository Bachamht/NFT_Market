pragma solidity ^0.8.4;

import "forge-std/Script.sol";
import {UniswapV2Factory} from "../src/uniswapV2_core/UniswapV2Factory.sol";
import {UniswapV2Router02} from "../src/uniswapV2_periphery/UniswapV2Router02.sol";
import {WETH9} from "../src/uniswapV2_periphery/WETH9.sol";

contract UniswapV2Deploy is Script {
    function setUp() public {}
    function run() public {
        address deployer = vm.rememberKey(vm.envUint("PRIVATE_KEY_LOCAL"));
        vm.startBroadcast(deployer);
        UniswapV2Factory factory = new UniswapV2Factory(deployer); 
        console.logBytes32(factory.INIT_CODE_PAIR_HASH());
        WETH9 weth = new WETH9();
        UniswapV2Router02 router = new UniswapV2Router02(address(factory), address(weth));

        console.log(address(factory));
        console.log(address(weth));
        console.log(address(router));

    }
}