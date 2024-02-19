// SPDX-License-Identifier: GPL-3.0


pragma solidity ^0.8.0;

interface IWithdraw {
        function ownerWithdraw() external;
}

contract Bank is IWithdraw{


    address internal owner;
    address internal administrator;
    address [10] private topThree;

    mapping(address => uint) internal balances;
    mapping(address => address) internal _nextSaver;
    uint256 public listSize;
    address constant GUARD = address(1);


    uint256 testT;
    error BalanceIsNotEnough(uint);
    
    constructor() {
        owner = msg.sender;
        _nextSaver[GUARD] = GUARD;
    }

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

     /**
     * user deposit
     */
    function deposit() virtual internal {
        
        uint256 amount = msg.value;
        address user = msg.sender;
        uint256 balance = amount += balances[msg.sender];
        if (_nextSaver[msg.sender] == address(0)){
            addDepositer(msg.sender, balance);
        }else{
            updateBalance(msg.sender, balance);
        }
    }

    /**
     * Administrator withdraws all money
     */
    function ownerWithdraw() public onlyAdministrator{
        address payable moneyOwner = payable(msg.sender);
        balances[moneyOwner] = 0;
        moneyOwner.transfer(address(this).balance);
    }

    /**
     * user withdraws money
     */
    function userWithdraw(uint amount) public {
        address payable user = payable(msg.sender);
        if (amount > balances[user]) revert BalanceIsNotEnough(balances[user]);
        uint userBalance = balances[user];
        balances[user] = 0;
        require(userBalance > 0,  "Balance too low"); 
        user.transfer(userBalance);
    }

    /**
     * view bank's total balance 
     */
    function viewTotalAmount() public view onlyOwner returns(uint) {
        return address(this).balance;
    }

  

    /**
     * View the amounts of the first three deposits
     */
    function viewBalance() public view returns(uint) {
        return balances[msg.sender];
    }

     /**
     * get pre depositer
     */
     function _getPredepositer(address depositer) internal view returns(address) {
        address currentAddress = GUARD;
        while(_nextSaver[currentAddress] != GUARD) {
            if (_nextSaver[currentAddress] == depositer) {
                return currentAddress;
            }
            currentAddress = _nextSaver[currentAddress];
        }
        return address(0);
     }

    /**
     * view the top 10 depositers
     */
    function viewTopTen() public view onlyOwner returns(address[] memory){
        address[] memory depositers = new address[](listSize);
        address currentAddress = _nextSaver[GUARD];
        for (uint i = 0; i < 10; ++i) {
            depositers[i] = currentAddress;
            currentAddress = _nextSaver[currentAddress];
        }
        return depositers;
    }

    /**
     * Verify that the newly added deposit is in the correct location
     */
    function _verifyIndex(address preDepositer, uint256 newBalance, address nextDepositer) internal view returns(bool) {
        return (preDepositer == GUARD || balances[preDepositer] >= newBalance) &&
               (nextDepositer == GUARD || newBalance > balances[nextDepositer]);
    }

    /**
     * find the newly added deposit where to be inserted
     */
    function _findIndex(uint256 newValue) internal view returns(address) {
        address candidateAddress = GUARD;
        while(true) {
            if(_verifyIndex(candidateAddress, newValue, _nextSaver[candidateAddress]))
                return candidateAddress;
                candidateAddress = _nextSaver[candidateAddress];
        } 
    }

    /**
     * add the deposit 
     */
    function addDepositer(address depositer, uint256 newBalance) internal {
        address index = _findIndex(newBalance);
        balances[depositer] = newBalance;
        _nextSaver[depositer] = _nextSaver[index];
        _nextSaver[index] = depositer;
        listSize++;
    }
    
    /**
     * remove the depositer
     */
    function removeDepositer(address depositer) internal {
        address prevDepositer = _getPredepositer(depositer);
        _nextSaver[prevDepositer] = _nextSaver[depositer];
        _nextSaver[depositer] = address(0);
        listSize--;
    }

     /**
     * update the deposit 
     */
    function updateBalance(address depositer, uint256 newBalance) internal {
        address prevDepositer = _getPredepositer(depositer);
        address nextDepositer = _nextSaver[depositer];
        if(_verifyIndex(prevDepositer, newBalance, nextDepositer)){
        balances[depositer] = newBalance;
        } else {
        removeDepositer(depositer);
        addDepositer(depositer, newBalance);
        }
    }

    /**
     * verify the depositer
     */
    function isDepositer(address depositer) public returns(bool){
        return (_nextSaver[depositer] != address(0));
    }

    function viewlistamount() public returns(uint256){
        return listSize;
    }

    function  viewAddtest(address test) public returns(address) {
        return _nextSaver[test];
    }
    
    function viewtestT() public returns(uint256) {
        return testT;
    }

}