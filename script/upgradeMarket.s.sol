// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/Script.sol";
import "./BaseScript.s.sol";
import {Upgrades, Options} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {NFTMarket} from "src/NFTMarket.sol";
import {NFTMarketV1} from "src/NFTMarketV1.sol";


contract UpgradeMarketScript is BaseScript{

    address proxyAddress;

    function run() public {
        vm.startBroadcast(admin);
        Options memory opts;
        opts.unsafeSkipAllChecks = true;

        // proxyAddress = Upgrades.deployTransparentProxy(
        // "NFTMarket.sol",
        // admin,
        // abi.encodeCall(NFTMarket.initialize, (0x47f1d75fd1A6f9530efa50e2Ed0C61a2B236e9a2,0xfCEe1e76831076b395A4F22Fd884f63929523E0d)),
        // opts
        // );

        address adminAddress = Upgrades.getAdminAddress(proxyAddress);
        address implementationAddress = Upgrades.getImplementationAddress(proxyAddress);
        console.log("Market Proxy contract deployed on %s", address(proxyAddress));
        console.log("Market contract deployed on %s", address(implementationAddress));
        console.log("admin contract deployed on %s", address(adminAddress));       
    }

    function upgradeContract() public { 
        vm.startBroadcast(admin);
        Options memory opts;
        opts.unsafeSkipAllChecks = true;
        opts.referenceContract = "NFTMarket.sol";

        Upgrades.upgradeProxy(
             0xD659236296Dd08EDABB07c47295a68CC5871fce6,
            "NFTMarketV1.sol",
            "",
            opts
        );

        address adminAddress = Upgrades.getAdminAddress(0xD659236296Dd08EDABB07c47295a68CC5871fce6);
        address implementationAddress = Upgrades.getImplementationAddress(0xD659236296Dd08EDABB07c47295a68CC5871fce6);


        console.log("Market contract deployed on %s", address(implementationAddress));
        console.log("admin contract deployed on %s", address(adminAddress));      

    }
}
