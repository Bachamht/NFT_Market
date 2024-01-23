// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface ItokenRecieved {
     function tokensRecieved(address from, address to, uint amount, bytes memory data) external; 
} 

contract btcToken is ERC20{
    
    constructor() ERC20("bitcoin", "BTC"){
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

   //铸造代币给对应用户
   function distributeTokens(address receiver, uint amount) public onlyOwner{
        _mint(receiver, amount);
        emit MintSuccess(receiver, amount);
   }
   
     
   function tokenTransferWithCallback(address to, uint amount, bytes memory data) public{
        _transfer(msg.sender, to, amount);
        ItokenRecieved(to).tokensRecieved(msg.sender, to, amount, data);
        emit transferSuccess(msg.sender, to, amount);
   }

   


}
