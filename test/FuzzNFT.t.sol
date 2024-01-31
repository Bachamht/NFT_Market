/*
    使用Fuzz测试 Bank 合约的存款和取款功能
    使用Fuzz测试 NFTMaket 合约的 transferWithCallbak
    注册 Dune 账号
*/

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {NFTMarket} from "../src/NFTMarket.sol";
import {btcToken}  from "../src/Token.sol";
import {MyNFT}    from "../src/MyNFT.sol";

contract Fuzz_market_test is Test{
        NFTMarket market;  
        btcToken  token;
        MyNFT     nft; 
    
        address admin = makeAddr("myadmin");
        address buyer = makeAddr("buyer");
        address seller = makeAddr("seller");
    
    
    function setUp() public {
        vm.startPrank(admin);{
            token = new btcToken();
            nft = new MyNFT();
            market = new NFTMarket();
            market.initialize(address(nft), address(token));
        }
        vm.stopPrank();
        list();
        mintCoin();
    }
    function list() internal {
        //用户seller铸造NFT
        vm.startPrank(admin);{
            for(uint i = 0; i < 1000; i++){
                nft.mint(seller, "ipfs://test1");
            }

            vm.startPrank(seller);{
            for(uint i = 1; i < 1001; i++){
                nft.approve(address(market), i);
            } 
            }
            vm.stopPrank();
        }
        vm.stopPrank();
    }

    function mintCoin() internal {
        vm.startPrank(admin);{
            token.distributeTokens(buyer, 1000000);
            uint256 balance = token.balanceOf(buyer);
            assertEq(balance, 1000000, "balance is not correct");
        }
        vm.stopPrank();
    }

    function test_fuzz_tokenTransferWithCallback(uint tokenID, uint amount) public {
                vm.assume(tokenID < 1000);
                vm.assume(tokenID > 0);
                vm.startPrank(seller);{
                    market.sellNFTs(tokenID, amount);
                }
                vm.startPrank(buyer);{
                    bytes memory data = abi.encode(tokenID);
                    token.tokenTransferWithCallback(address(market), 600, data);
                }       


    }
    

}


