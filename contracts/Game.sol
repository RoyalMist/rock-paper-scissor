pragma solidity 0.5.9;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Game {
    using SafeMath for uint;

    struct Player {
        uint bet;
        uint move;
        bytes32 sMove;
        bool won;
    }

    enum Move {ROCK, PAPER, SCISSORS}
    Move moves;
    uint _timeLimit;
    mapping(address => Player) _players;

    event LogSecretMovePlaced(address indexed who, uint when);

    constructor(address playerOne, address playerTwo, uint bet, uint gameDuration) public {
        require(playerOne != address(0x0) && playerTwo != address(0x0), "Please provide a valid opponents' addresses");
        require(gameDuration > 10 minutes, "Please set a game duration of more than 10 minutes");
        _players[playerOne].bet = bet;
        _players[playerTwo].bet = bet;
        _timeLimit = now.add(gameDuration);
    }

    function hash(address player, bytes32 mnemonic, uint move) public view returns (bytes32 hashed) {
        require(player != address(0x0) && mnemonic != 0 && uint(Move.SCISSORS) >= move, "Please provide valid inputs");
        hashed = keccak256(abi.encodePacked(address(this), player, mnemonic, move));
    }

    function placeSecretMove(bytes32 secretMove) public {
        require(now < _timeLimit && _players[msg.sender].sMove == 0, "Game has ended or you already played");
        require(_players[msg.sender].bet == 0 && secretMove != 0, "A move must be correct and placed with your bet fully paid");
        _players[msg.sender].sMove = secretMove;
        emit LogSecretMovePlaced(msg.sender, now);
    }

    function revealMove(bytes32 mnemonic, uint move) public {
        //TODO validate hash
    }

    function resolveWinner() private {
        //TODO resolve
    }

    function withdraw() public {
        //TODO withdraw
    }

    function() payable external {
        require(msg.value <= _players[msg.sender].bet, "Do not provide more than the game bet");
        _players[msg.sender].bet = _players[msg.sender].bet.sub(msg.value);
    }
}
