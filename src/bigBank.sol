// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol";
import './bank.sol';
contract BigBank is Bank {
    
    error AmountNotEnough(uint amount);
    error NotContractAddress(address Ownable);
    uint constant MINDEPOSIT = 0.001 ether;

    modifier amountCheck(uint amount) {
        if(amount <= MINDEPOSIT ) revert AmountNotEnough(amount);
        _;
    }

  
    //用户存款
    function deposit() internal amountCheck(msg.value) override {
        balances[msg.sender] += msg.value;
    }

    //向合约授予管理员权限
    function grantPermission(address Ownable) public onlyOwner{
        if(isContract(Ownable) == false) {
            revert NotContractAddress(Ownable);
        }
        administrator = Ownable;
    }
    
    //合约地址与外部地址判断
    function isContract(address addr) internal view returns (bool) {
        uint256 size;
        assembly { size := extcodesize(addr) }
         return size > 0;
    }
    
    //查看余额
    function balanceOf(address who) public returns(uint256){
        return balances[who];
    }
    
   /*
    function permitDeposit(address user, uint amount, uint deadline, uint8 v, bytes32 r, bytes32 s) external {
        IERC20Permit(token).permit(msg.sender, address(this), amount, deadline, v, r, s);
        IERC20(token).transferFrom(msg.sender, address(this), amount);
        balances[user] += amount;   
    }
    */

    

}
