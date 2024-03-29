// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Bank} from "../src/bank.sol";
import {BigBank} from "../src/bigBank.sol";

contract Fuzz_bank_test is Test {
    BigBank bigbank;

    address admin = makeAddr("myadmin");
    address user = makeAddr("buyer");

    function setUp() public {
        vm.startPrank(admin);
        {
            bigbank = new BigBank();
        }
        vm.stopPrank();
        deal(user, 100000 ether);
    }

    function test_fuzz_deposit(uint amount) public {
        vm.assume(amount < 100000 ether);
        vm.assume(amount > 0);
        vm.startPrank(user);
        {
            if (amount <= 0.001 ether) {
                bytes memory wantErr = abi.encodeWithSelector(
                    BigBank.AmountNotEnough.selector,
                    amount
                );

                vm.expectRevert(wantErr);
                (bool success2, ) = address(bigbank).call{value: amount}("");
                assertTrue(success2, "expect deposit ok!");
                console.logBytes(wantErr);
                vm.expectRevert(wantErr);

                console.log("haha");
                return;
            }
            uint beforeBalance = bigbank.balanceOf(user);
            (bool success3, ) = address(bigbank).call{value: amount}("");
            assertTrue(success3, "expect deposit ok!");
            uint balance = bigbank.balanceOf(user);
            assertEq(balance, beforeBalance + amount, "deposit wrong");
        }
        vm.stopPrank();
    }

    function test_fuzz_withdraw(uint amount) public {
        vm.startPrank(user);
        {
            vm.assume(amount < bigbank.balanceOf(user));
            uint beforeBalance = bigbank.balanceOf(user);
            bigbank.userWithdraw(amount);
            uint balance = bigbank.balanceOf(user);
            assertEq(balance, beforeBalance - amount, "deposit wrong");
        }
        vm.stopPrank();
    }
}
