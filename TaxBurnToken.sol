// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.2;

contract TaxBurnToken {
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowance;
    uint public totalSupply = 1000000 * 10 ** 18;
    string public name = "TaxBurnToken";
    string public symbol = "TBT";
    uint public decimals = 18;
    uint public transactionTax = 5;
    address public burnaddress = 0x0000000000000000000000000000000000000001;
    
    
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
    
    constructor() {
        balances[msg.sender] = totalSupply;
    }
    
    function calculateTaxFee(uint amount) private view returns (uint) {
        return (amount*(100-transactionTax))/100;
    }
    
    function balanceOf(address owner) public view returns (uint) {
        return balances[owner];
    }
    
    function transfer(address to, uint value) public returns(bool) {
        require(balanceOf(msg.sender) >= value, 'balance too low');
        // calculate value minus tax
        uint netValue = calculateTaxFee(value);
        // calculate value to burn
        uint valueToBurn = value - netValue;
        balances[to] = balances[to] + netValue;
        balances[msg.sender] -= value;
        // burn token
        balances[burnaddress] += valueToBurn;
        emit Transfer(msg.sender, to, netValue);
        emit Transfer(msg.sender, burnaddress, valueToBurn);
        return true;
    }
    
    function transferFrom(address from, address to, uint value) public returns(bool) {
        require(balanceOf(from) >= value, 'balance too low');
        require(allowance[from][msg.sender] >= value, 'allowance too low');
        balances[to] += value;
        balances[msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }
    
    function approve(address spender, uint value) public returns(bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
    
}
