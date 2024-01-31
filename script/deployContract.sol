// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "./BaseScript.s.sol";
import {MyNFT} from "src/MyNFT.sol";
import {btcToken} from "src/Token.sol";


contract Deploy is Script, BaseScript {

    function deployToken() public {
        vm.startBroadcast(privateKEY);
        btcToken token = new btcToken();
        console.log("Token:",address(token));
    }

    function deployNFT() public {
        vm.startBroadcast(privateKEY);
        MyNFT nft = new MyNFT();
        console.log("NFT:",address(nft));
    }

    //token address : 0xfCEe1e76831076b395A4F22Fd884f63929523E0d
    //nft address : 0x47f1d75fd1A6f9530efa50e2Ed0C61a2B236e9a2

    //Market: 0xdaE97900D4B184c5D2012dcdB658c008966466DD

}