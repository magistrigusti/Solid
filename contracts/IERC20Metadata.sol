// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "./IERC20.sol";

interface IERC20Metadata is IERC20 {
  function name() external view returns(string memory);
  
  function symbol() external view returns(string memory);

  function decimals() external view returns(uint8);
}