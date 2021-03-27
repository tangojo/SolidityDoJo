/*
    Dividend Bearing Token
    
    - every token transaction/transfer is taxed
    - the tax is distributed among token holders
    - See https://weka.medium.com/dividend-bearing-tokens-on-ethereum-42d01c710657

*/


// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

contract DividendBearingToken {
    
    struct Account {
        uint balance;
        uint lastDividends;
    }
    
    mapping(address=>Account) accounts;
    
    mapping(address => mapping(address => uint)) public allowance;
    uint public totalSupply = 1000000;
    string public name = "DividendBearingToken";
    string public symbol = "DBT";
    uint public decimals = 0;
    uint public transactionTax = 5;
    uint public totalDividends;
    
    
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
    
    constructor() { 
        accounts[msg.sender].balance = totalSupply;
    }
    
    function dividendsOwing(address account) internal view returns(uint) {
      uint newDividends = totalDividends - accounts[account].lastDividends;
      return (accounts[account].balance * newDividends) / totalSupply;
        }
    
    modifier updateAccount(address account) {
      uint owing = dividendsOwing(account);
      if(owing > 0) {
        accounts[account].balance += owing;
        accounts[account].lastDividends = totalDividends;
      }
      _;
    }
        
    function restValueAfterTaxFee(uint amount) private view returns (uint) {
        return (amount*(100-transactionTax))/100;
    }
    
    function balanceOf(address owner) public view returns (uint) {
        return accounts[owner].balance;
    }
    
    function lastDividendsOf(address owner) public view returns (uint) {
        return accounts[owner].lastDividends;
    }    
    
    function transfer(address to, uint value) updateAccount(msg.sender) public returns(bool)	 {
        require(balanceOf(msg.sender) >= value, 'balance too low');
        uint restValueAfterTax = restValueAfterTaxFee(value);
        accounts[msg.sender].balance -= value;
        accounts[to].balance += restValueAfterTax;
        uint netDividend = value - restValueAfterTax;
        totalDividends += netDividend;

        emit Transfer(msg.sender, to, netDividend);
        return true;
    }
    
    function transferFrom(address from, address to, uint value) updateAccount(from) public returns(bool) {
        require(balanceOf(from) >= value, 'balance too low');
        require(allowance[from][msg.sender] >= value, 'allowance too low');
        uint restValueAfterTax = restValueAfterTaxFee(value);
        accounts[msg.sender].balance -= value;
        accounts[to].balance += restValueAfterTax;
        uint netDividend = value - restValueAfterTax;
        totalDividends += netDividend;
        emit Transfer(from, to, value);
        return true;
    }
    
    function approve(address spender, uint value) public returns(bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }   
    
}
