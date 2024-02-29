
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {NFTMarket}   from "../src/NFTMarket.sol";
import {CGToken}  from "../src/Token.sol";
import {MyNFT}    from "../src/MyNFT.sol";
import {UniswapV2Router02} from "../src/uniswapV2_periphery/UniswapV2Router02.sol";
import {UniswapV2Factory} from "../src/uniswapV2_core/UniswapV2Factory.sol";
import {WETH9} from "../src/uniswapV2_periphery/WETH9.sol";
contract Whitelist_test is Test{
        NFTMarket market;    
        CGToken  token;
        MyNFT     nft;
        UniswapV2Factory factory;
        UniswapV2Router02 router;
        WETH9 weth;
        address owner;
        uint256 ownerPkey;
        address buyer = makeAddr("buyer");
        bytes32 private constant BuyNFT_TYPEHASH = keccak256("BuyNFT(address buyer,uint256 tokenID)");
        bytes32 private constant EIP712DOMAIN_TYPEHASH = keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)");
        bytes32 private DOMAIN_SEPARATOR;

    
    
    function setUp() public {
    
        (owner, ownerPkey) = makeAddrAndKey("owner");
        vm.startPrank(owner);{
            token = new CGToken();
            nft = new MyNFT();
            market = new NFTMarket();
            factory = new UniswapV2Factory(owner);
            weth = new WETH9();
            router = new UniswapV2Router02(address(factory), address(weth));
            market.initialize(address(nft), address(token), address(factory), address(weth), address(router));
            DOMAIN_SEPARATOR = keccak256(abi.encode(
                EIP712DOMAIN_TYPEHASH, 
                keccak256(bytes("EIP712Storage")), 
                keccak256(bytes("1")), 
                block.chainid, 
                address(market) 
            ));
        }
        vm.stopPrank();
    }
  
   
    function test_WhitelistBuy() public {
        bytes  memory signature;
        vm.startPrank(owner);{

            bytes32 _msgHash = keccak256(abi.encodePacked(
                "\x19\x01",
                DOMAIN_SEPARATOR,
                keccak256(abi.encode(BuyNFT_TYPEHASH, address(buyer), 1))
            )); 

            (uint8 v, bytes32 r, bytes32 s) = vm.sign(ownerPkey, _msgHash);
            signature = abi.encodePacked(r, s, v);
        }
        vm.stopPrank();

        vm.startPrank(buyer);{
            market.WhitelistBuy(1,  signature);
        }
        vm.stopPrank();

    }


}
