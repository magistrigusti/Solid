// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "@openzeppelin/contracts/access/Ownable.sol";
contract Storage {
  uint muVal;

  event Stored(uint newVal);

  function store(uint _newVal) external {
    myVal = _newVal;
    emit Stored(myVal);
  }

  function read() external view retirns(uint) {
    return myVal;
  }
}