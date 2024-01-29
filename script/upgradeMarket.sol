// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/Script.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

/*
• 部署一个可升级的 NFT 市场合约

• 第一版本普通合约

• 第二版本,加入离线签名上架 NFT 功能方法(签名内容:tokenId, 价格),实现用户一次性
setApproveAll 给 NFT 市场合约,每次上架时使用签名上架。

• 部署到测试网,并开源到区块链浏览器(在 Readme.md 中备注代理合约及两个实现的合约地址)
*/

contract upgradeMarket {

    address proxy = Upgrades.deployTransparentProxy(
        "MarketUpgrade.sol",
        0x8FD116DaF3A17Fc2e8D10579EDB19c788Bb93A64,
        ""
        //abi.encodeCall(MyContract.initialize, ("arguments for the initialize function"))
    );


}
