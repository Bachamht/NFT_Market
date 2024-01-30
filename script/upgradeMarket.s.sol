// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/Script.sol";
import "./BaseScript.s.sol";
import {Upgrades, Options } from "openzeppelin-foundry-upgrades/Upgrades.sol";

/*
• 部署一个可升级的 NFT 市场合约

• 第一版本普通合约

• 第二版本,加入离线签名上架 NFT 功能方法(签名内容:tokenId, 价格),实现用户一次性
setApproveAll 给 NFT 市场合约,每次上架时使用签名上架。

• 部署到测试网,并开源到区块链浏览器(在 Readme.md 中备注代理合约及两个实现的合约地址)
*/

contract upgradeMarket is BaseScript{

    function run() public {

        Options memory opts;

        address proxy = Upgrades.deployTransparentProxy(
            "NFTMarket.sol",// INITIAL_OWNER_ADDRESS_FOR_PROXY_ADMIN,
            "",         // abi.encodeCall(MyContract.initialize, ("arguments for the initialize function")
            opts
            );

        console.log("Counter deployed on %s", address(proxy));
    }

}
