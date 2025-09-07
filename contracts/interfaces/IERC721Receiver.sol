// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

interface IERC721Receiver {
  function onIERC721Receiver(
    address operator, address from, uint tokenId, bytes calldata data
  ) external returns(bytes4);
}