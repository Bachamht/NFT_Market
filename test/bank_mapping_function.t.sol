// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Bank} from "../src/bank.sol";
import {BigBank} from "../src/bigBank.sol";

contract bank_mapping_test is Test {
    BigBank bigbank;

    address admin = makeAddr("myadmin");
    address user1 = makeAddr("user1");
    address user2 = makeAddr("user2");
    address user3 = makeAddr("user3");
    address user4 = makeAddr("user4");
    address user5 = makeAddr("user5");
    address user6 = makeAddr("user6");
    address user7 = makeAddr("user7");
    address user8 = makeAddr("user8");
    address user9 = makeAddr("user9");
    address user10 = makeAddr("user10");
    address user11 = makeAddr("user11");


    function setUp() public {
      
        bigbank = new BigBank();
        deal(user1, 100000 ether);
        deal(user2, 100000 ether);
        deal(user3, 100000 ether);
        deal(user4, 100000 ether);
        deal(user5, 100000 ether);
        deal(user6, 100000 ether);
        deal(user7, 100000 ether);
        deal(user8, 100000 ether);
        deal(user9, 100000 ether);
        deal(user10, 100000 ether);
        deal(user11, 100000 ether);
    }

    function test_deposit() public {
      
        vm.startPrank(user1);
        {
            address(bigbank).call{value: 1 ether}("");
        }
        vm.stopPrank();

        vm.startPrank(user2);
        {
            address(bigbank).call{value: 3 ether}("");
        }
        vm.stopPrank();

        vm.startPrank(user3);
        {
            address(bigbank).call{value: 2 ether}("");

        }
        vm.stopPrank();

        vm.startPrank(user4);
        {
            address(bigbank).call{value: 4 ether}("");
        }
        vm.stopPrank();

        vm.startPrank(user5);
        {
            address(bigbank).call{value: 5 ether}("");
        }
        vm.stopPrank();

        vm.startPrank(user6);
        {
            address(bigbank).call{value: 6 ether}("");
        }
        vm.stopPrank();

        vm.startPrank(user7);
        {
            address(bigbank).call{value: 7 ether}("");
        }
        vm.stopPrank();

        vm.startPrank(user8);
        {
            address(bigbank).call{value: 8 ether}("");
        }
        vm.stopPrank();

        vm.startPrank(user9);
        {
            address(bigbank).call{value: 9 ether}("");
        }
        vm.stopPrank();

        vm.startPrank(user10);
        {
            address(bigbank).call{value: 10 ether}("");
        }
        vm.stopPrank();

        vm.startPrank(user11);
        {
            address(bigbank).call{value: 11 ether}("");
        }
        vm.stopPrank();

        vm.startPrank(user2);
        {
            address(bigbank).call{value: 99 ether}("");
        }
        vm.stopPrank();
        bigbank.viewTopTen();
    }

}