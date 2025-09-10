// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "../interfaces/ERC721.sol";

abstract contract ERC721URIStorage is ERC721 {
  mapping(uint => string) private _tokenURIs;

  
}