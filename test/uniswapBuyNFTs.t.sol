  
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {NFTMarket} from "../src/NFTMarket.sol";
import {CGToken}  from "../src/Token.sol";
import {MyNFT}    from "../src/MyNFT.sol";
import {UniswapV2Router02} from "../src/uniswapV2_periphery/UniswapV2Router02.sol";
import {UniswapV2Factory} from "../src/uniswapV2_core/UniswapV2Factory.sol";
import {WETH9} from "../src/uniswapV2_periphery/WETH9.sol";
import {TestCoin}  from "../src/ERC20Test.sol";


contract Fuzz_bank_test is Test {
    NFTMarket market;  
    CGToken  token;
    MyNFT     nft; 
    UniswapV2Factory factory;
    UniswapV2Router02 router;
    WETH9 weth;
    TestCoin test;
    address admin = makeAddr("myadmin");
    address buyer = makeAddr("buyer");
    address seller = makeAddr("seller");
    
    function setUp() public {
        vm.startPrank(admin);
            token = new CGToken();
            nft = new MyNFT();
            market = new NFTMarket();
            factory = new UniswapV2Factory(admin);
            weth = new WETH9();
            test = new TestCoin();
            router = new UniswapV2Router02(address(factory), address(weth));
            market.initialize(address(nft), address(token), address(factory), address(weth), address(router));
            list();
        vm.stopPrank();
    }

    //path1: ERC20Token -> CG(Platform currency)
    function test_path1Buy() public{
        vm.startPrank(admin);
        distributeToken();
        UniswapV2Router02(router).addLiquidity(address(test), address(token), 50000, 30000, 99900, 990, admin, block.timestamp + 600);
        vm.stopPrank();

        vm.startPrank(buyer);
        test.approve( address(router), 100000);
        market.buyByERC20Token(address(test), 1, 650, false);
        console.log(test.balanceOf(buyer));
        console.log(token.balanceOf(seller));
        vm.stopPrank();
    }

    //path2: ERC20Token -> WETH -> CG(Platform currency)
    function test_path2Buy() public {
        vm.startPrank(admin);
        distributeToken();
        UniswapV2Router02(router).addLiquidityETH(address(test), 50000, 49900, 100, admin, block.timestamp + 600);
        UniswapV2Router02(router).addLiquidityETH(address(token), 80000, 49900, 150, admin, block.timestamp + 600);
        vm.stopPrank();

        vm.startPrank(buyer);
        test.approve( address(router), 100000);
        market.buyByERC20Token(address(test), 1, 650, true);
        console.log(test.balanceOf(buyer));
        console.log(token.balanceOf(seller));
        vm.stopPrank();

    }

    function distributeToken() public {
        vm.startPrank(admin);
        test.distributeTokens(admin, 1000000);
        token.distributeTokens(admin, 1000000);
        test.distributeTokens(buyer, 1000000);
        vm.stopPrank();
    }

    function list() internal {
        vm.startPrank(admin);{
            nft.mint(seller, "ipfs://test1");
            nft.mint(seller, "ipfs://test2");
            nft.mint(seller, "ipfs://test3");
        }
        vm.stopPrank();

         
        vm.startPrank(seller);{
            nft.approve(address(market), 1);
            nft.approve(address(market), 2);
            nft.approve(address(market), 3);
            market.sellNFTs(1, 600);
            market.sellNFTs(2, 800);
            market.sellNFTs(3, 1000);
        }
        vm.stopPrank();
    }

  

}
     

  