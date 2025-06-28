// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract IERC721Receiver {

  function onERC721Received(
    address operator,
    address from,
    uint256 tokenId,
    bytes data
  )
    public
    returns(bytes4);
}