// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "./IERC165";

interface IERC1155Receiver is IERC165 {
  function onERC1155Received(
    address operator,
    address from,
    uint256 id,
    uint256 value,
    bytes calldata data
  ) external returns (bytes4);

  function onERC1155BatcReceived(
    address operator,
    address from,
    uint256[] calldata ids,
    uint256[] calldata values,
    bytes calldata data
  ) external returns (bytes4)
}