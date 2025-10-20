// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract Storage {
  uint public val;

  function initialize(uint _val) external {
    val = _val;
  }
}