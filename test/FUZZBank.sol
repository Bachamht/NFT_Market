/*
    使用Fuzz测试 Bank 合约的存款和取款功能
    使用Fuzz测试 NFTMaket 合约的 transferWithCallbak
    注册 Dune 账号
*/


// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Bank}      from "../src/bank.sol";
import {BigBank}   from "../src/bigBank.sol";

contract Fuzz_bank_test is Test{
        BigBank bigbank;    

        address admin = makeAddr("myadmin");
        address user = makeAddr("buyer");
    
    
    function setUp() public {

        vm.startPrank(admin);{
            bigbank = new BigBank();
        }
        vm.stopPrank();
        deal(user, 100000 ether);
    
    }
  

    function test_fuzz_deposit(uint amount) public {
                vm.assume(amount < 100000 ether);
                vm.assume(amount > 0);
                vm.startPrank(user);{
                    if (amount <= 0.001 ether){
                        /*
                        (bool success,) = address(bigbank).call{value:amount}("");
                        bytes memory wantErr = abi.encodeWithSelector(BigBank.AmountNotEnough.selector,amount); 
                        console.logBytes(wantErr);
                        vm.expectRevert(wantErr);
                        */
                        console.log("haha");
                        return;
                    }
                    uint beforeBalance = bigbank.balanceOf(user);
                   (bool success,) = address(bigbank).call{value:amount}("");
                    assertTrue(success,"expect deposit ok!");                    
                    uint balance = bigbank.balanceOf(user);
                    assertEq(balance, beforeBalance + amount, "deposit wrong");
                }
                vm.stopPrank();
    }

    function test_fuzz_withdraw(uint amount) public {
        vm.startPrank(user);{
            vm.assume(amount < bigbank.balanceOf(user));
            uint beforeBalance = bigbank.balanceOf(user);
            bigbank.userWithdraw(amount);
            uint balance = bigbank.balanceOf(user);
            assertEq(balance, beforeBalance - amount, "deposit wrong");
        }
        vm.stopPrank();

    }
}


