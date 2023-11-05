// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BankAccount {
    address public owner;
    uint256 public balance;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this operation");
        _;
    }

    function deposit() public payable {
        require(msg.value > 0, "You must deposit some Ether");
        balance += msg.value;
    }

    function withdraw(uint256 amount) public onlyOwner {
        require(balance >= amount, "Insufficient balance");
        balance -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getBalance() public view returns (uint256) {
        return balance;
    }

    function transfer(address recipient, uint256 amount) public onlyOwner {
        require(balance >= amount, "Insufficient balance");
        balance -= amount;
        payable(recipient).transfer(amount);
    }
}
