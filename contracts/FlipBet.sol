// SPDX-License-Identifier: smartcontract201
pragma solidity 0.6.12;

contract FlipBet {
    uint public contractBalance;
    
    constructor() public payable {
        sendFundToContract();
    }

    function random() public view returns(uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, now))) % 2;
    }

    function sendFundToPlayer(uint amt) public {
        require(amt <= contractBalance, "Contract doesn't have enough balance!");
        msg.sender.transfer(amt);
        contractBalance -= amt;
    }

    function sendFundToContract() public payable {
        require(msg.value <= msg.sender.balance, "Player doesn't have enough balance!");
        contractBalance += msg.value;
    }
    
    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }
}