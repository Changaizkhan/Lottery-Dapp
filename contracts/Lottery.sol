// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract Lottery{
    address payable[] public players;
    address payable public winner;
    address public manager;
    constructor(){
        manager==msg.sender;

    }
    receive()payable external
    {
        require(msg.value==1 ether,"Please pay 1 ether");
        players.push(payable(msg.sender));
    

    }
    function getBalance() public view returns (uint){
        require(manager==msg.sender,"you are not manager");
        return address(this).balance;
    }

    function random() internal view returns(uint){
       return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)));
    }

    function pickWinner() public{
        require(msg.sender==manager,"only manager can use this");
        require(players.length>=3,"player are less then 3");
        uint r= random();
        uint index= r % players.length;
        winner=players[index];
        winner.transfer(getBalance());
        players = new address payable[](0);
    }
    function allPlayers() public view returns(address payable[] memory)
    {
        return players;
    }
}
