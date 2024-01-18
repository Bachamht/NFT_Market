// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

interface IWithdraw {
        function ownerWithdraw() external;
}

contract Bank is  IWithdraw{

    constructor() {
        owner = msg.sender;
    }

    address internal owner;
    address internal administrator;
    mapping(address => uint) internal balances;
    address [3] private topThree;

    error BalanceIsNotEnough(uint);
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not administrator ");
        _;
    }
    

    modifier onlyAdministrator() {
         require(msg.sender == administrator, "Not administrator ");
        _;
    }

    
    receive() external payable { 
        deposit();
    }

    //用户存款
    function deposit() virtual internal {
        
        uint  amount = msg.value;
        address user = msg.sender;
        balances[user] += amount;
        updateThree(user);
    }

    //topThree更新
    function updateThree(address user) private {
        uint min = balances[user];
        uint minIndex = 3;
        for (uint i = 0; i < 3; i++) {
            if (topThree[i] == user) {
                minIndex = 3;
                break;
            }
            if (balances[topThree[i]] < min) {
                min = balances[topThree[i]];
                minIndex = i;
            }
        }
        if (minIndex < 3) {
            topThree[minIndex] = user;
        }
    }
    //管理员取出所有ETH
    function ownerWithdraw() public onlyAdministrator{
        address payable moneyOwner = payable(msg.sender);
        balances[moneyOwner] = 0;
        moneyOwner.transfer(address(this).balance);
    }

    //用户取出存款
    function userWithdraw(uint amount) public {
        address payable user = payable(msg.sender);
        if (amount > balances[user]) revert BalanceIsNotEnough(balances[user]);
        uint userBalance = balances[user];
        balances[user] = 0;
        require(userBalance > 0,  "Balance too low"); 
        user.transfer(userBalance);
    }

    //查看银行存款总额
    function viewTotalAmount() public view onlyOwner returns(uint) {
        return address(this).balance;
    }

    //查看存款前三的金额
    function viewTopThree() public view onlyOwner returns(address[3] memory){
        return topThree;
    }

    //用户查看自身余额
    function viewBalance() public view returns(uint) {
        return balances[msg.sender];
    }


 

}
