// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract StorageV2 {
  uint public val;

  function inc() external {
    val++;
  }
}