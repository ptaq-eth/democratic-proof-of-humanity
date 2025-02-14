// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";

contract ProofofHumanity {
  using SafeMath for uint256;
  using SafeERC20 for ERC20;

  // Set up the ERC20 token
  ERC20 private _token;
  string public name;
  string public symbol;
  uint8 public decimals;
  uint256 public totalSupply;

  // Set up the registry
  struct Human {
      string name;
      string description;
      uint256 applicationDate;
      uint256 voteBy;
      bool accepted;
      uint256 deposit;
  }
  mapping(uint256 => Human) public humans;
  uint256 public humanCount;

  // Set up the parameters for the registry
  uint256 public minDeposit;
  uint256 public applyStageLength;
  uint256 public votingStageLength;
  uint256 public minQuorum;
  uint256 public voteQuorum;
  uint256 public votingPeriodLength;

  // Set up the contract owner and the curator
  address public owner;
  address public curator;

  // Set up the events
  event HumanAdded(uint256 indexed humanId, string name, string description, uint256 deposit);
  event HumanRemoved(uint256 indexed humanId, string name, string description, uint256 deposit);
  event HumanAccepted(uint256 indexed humanId, string name, string description, uint256 deposit);
  event HumanRejected(uint256 indexed humanId, string name, string description, uint256 deposit);

  constructor(
      address _curator,
      ERC20 _token,
      string memory _name,
      string memory _symbol,
      uint8 _decimals,
      uint256 _totalSupply,
      uint256 _minDeposit,
      uint256 _applyStageLength,
      uint256 _votingStageLength,
      uint256 _minQuorum,
      uint256 _voteQuorum,
      uint256 _votingPeriodLength
  ) public {
      // Set the owner and curator
      owner = msg.sender;
      curator = _curator;

      // Set up the ERC20 token
      _token = _token;
      name = _name;
      symbol = _symbol;
      decimals = _decimals;
      totalSupply = _totalSupply;
      _token.initialize(totalSupply);

      // Set up the registry parameters
      minDeposit = _minDeposit;
      applyStageLength = _applyStageLength;
      votingStageLength = _votingStageLength;
      minQuorum = _minQuorum;
      voteQuorum = _voteQuorum;
      votingPeriodLength = _votingPeriodLength;
  }

  // Function to add a human to the registry
  function addHuman(string memory name, string memory description) public payable {
      require(msg.value >= minDeposit, "Deposit insufficient");
  }
}
