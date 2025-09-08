// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "../interfaces/IERC721.sol";
import "../ERC721URIStorage.sol";
import "../ERC721Enumerable.sol";

contract DomToken is  ERC721 {
  constructor() ERC721("Dominum", "DOM") {}
}