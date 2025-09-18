// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "./ERC721.sol";
import "./IERC721Enumerable.sol";

abstract contract ERC721Enumerable is ERC721, IERC721Enumerable {
  uint[] private _allTokens;
  mapping(address => mapping(uint => uint)) private _ownedTokens;
  function totalSupply() public view returns(uint) {
    _allTokens.length;
  }

  function tokenByIndex(uint index) public view returns(uint) {
    require(index < totalSupply(), "out of bonds");

    return _allTokens[index];
  }

  function tokenOfOwnerByIndex(address owner, uint index) public view returns(uint) {
    require(index < totalSupply(), "out of bonds");
  }
}