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

   
    /**
     * Set up an administrator for the contract
     */
    function grantPermission(address Ownable) public onlyOwner{
        if(isContract(Ownable) == false) {
            revert NotContractAddress(Ownable);
        }
        administrator = Ownable;
    }
    
    /**
     * Contract address and external address judgment
     */
    function isContract(address addr) internal view returns (bool) {
        uint256 size;
        assembly { size := extcodesize(addr) }
         return size > 0;
    }
    
    /**
     * view balance
     */
    function balanceOf(address who) public returns(uint256){
        return balances[who];
    }
    
  

    

}
