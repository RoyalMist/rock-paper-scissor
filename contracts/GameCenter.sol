pragma solidity 0.5.9;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract GameCenter is Ownable {
    mapping(address => bool) games;

    event LogGameCreated(address indexed playerOne, address indexed playerTwo, address indexed game);

    function initGame(address opponent, uint bet) public {
        require(opponent != address(0x0), "Please provide a valid opponent's address");
        //TODO instantiate a new GameContract
        emit LogGameCreated(msg.sender, opponent, address(0x0));
    }
}
