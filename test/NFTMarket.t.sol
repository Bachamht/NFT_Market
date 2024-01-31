// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {NFTMarket} from "../src/NFTMarket.sol";
import {btcToken}  from "../src/Token.sol";
import {MyNFT}    from "../src/MyNFT.sol";

contract NFTMarketTest is Test {
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

    function mintCoin() internal {
        vm.startPrank(admin);{
            token.distributeTokens(buyer, 5000);
            uint256 balance = token.balanceOf(buyer);
            assertEq(balance, 5000, "balance is not correct");
        }
        vm.stopPrank();
    }

    function test_List() public {

        list();
        vm.startPrank(buyer);{
            uint256 price1 = market.viewPrice(1);
            assertEq(price1, 600, "the price is different");
            uint256 price2 = market.viewPrice(2);
            assertEq(price2, 800, "the price is different");
            uint256 price3 = market.viewPrice(3);
            assertEq(price3, 1000, "the price is different");
        }
        vm.stopPrank();

    }
    
    function test_buy() public{
        
        list();
        mintCoin();
        vm.startPrank(admin);{
            token.distributeTokens(buyer, 5000);
            uint256 balance = token.balanceOf(buyer);
            assertEq(balance, 5000, "balance is not correct");
        }
        vm.stopPrank();
        
        vm.startPrank(buyer);{

            token.approve(address(market), 3000);
            uint256 allowance = token.allowance(buyer, address(market));
            assertEq(allowance, 3000, "allowance is not correct");
            market.buyNFT(1, 600);
            market.buyNFT(2, 800);
            market.buyNFT(3, 1000);

            address owner = market.viewOwner(1);
            assertEq(owner, buyer, "owner is not correct");
            owner = market.viewOwner(2);
            assertEq(owner, buyer, "owner is not correct");
            owner = market.viewOwner(3);
            assertEq(owner, buyer, "owner is not correct");

            uint amount = token.balanceOf(seller);
            assertEq(amount, 2400, "seller's balance is not correct");
            
            amount = token.balanceOf(buyer);
            assertEq(amount, 2600, "buyer's balance is not correct");

        }
        vm.stopPrank();
    }


    
    function test_tokenRecieved() public {
        
        list();
        mintCoin();
        vm.startPrank(admin);{
            token.distributeTokens(buyer, 5000);
            uint256 balance = token.balanceOf(buyer);
            assertEq(balance, 5000, "balance is not correct");
        }
        vm.stopPrank();

        vm.startPrank(buyer);{
            bytes memory tokenID1 = abi.encode(1);
            bytes memory tokenID2 = abi.encode(2);
            bytes memory tokenID3 = abi.encode(3);

            token.tokenTransferWithCallback(address(market), 600, tokenID1);
            token.tokenTransferWithCallback(address(market), 800, tokenID2);
            token.tokenTransferWithCallback(address(market), 1000,tokenID3);
            address owner = market.viewOwner(1);
            assertEq(owner, buyer, "owner is not correct");
            owner = market.viewOwner(2);
            assertEq(owner, buyer, "owner is not correct");
            owner = market.viewOwner(3);
            assertEq(owner, buyer, "owner is not correct");

            uint amount = token.balanceOf(seller);
            assertEq(amount, 2400, "seller's balance is not correct");
            
            amount = token.balanceOf(buyer);
            assertEq(amount, 2600, "buyer's balance is not correct");

        }
        vm.stopPrank(); 

    }


}
