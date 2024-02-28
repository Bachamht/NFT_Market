// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol";

interface ItokenRecieved {
     function tokensRecieved(address from, address to, uint amount, bytes memory data) external; 
} 

contract TestCoin is ERC20Permit{
    
    constructor() ERC20("test", "test") ERC20Permit("ERC2612"){
         owner = msg.sender;
    }

    address private owner;
    error NotOwner(address user);
    event MintSuccess(address user, uint amount);
    event transferSuccess(address user, address bank, uint amount);

    modifier onlyOwner{
        if(msg.sender != owner) revert NotOwner(msg.sender);
        _;
    }

   /**
     * Mint tokens to corresponding users
     */  
   function distributeTokens(address receiver, uint amount) public onlyOwner{
        _mint(receiver, amount);
        emit MintSuccess(receiver, amount);
   }
   
   /**
     * Directly transfer the token to an address and have a corresponding return function for processing.
     */  
   function tokenTransferWithCallback(address to, uint amount, bytes memory data) public{
        _transfer(msg.sender, to, amount);
        ItokenRecieved(to).tokensRecieved(msg.sender, to, amount, data);
        emit transferSuccess(msg.sender, to, amount);
   }

 

}
