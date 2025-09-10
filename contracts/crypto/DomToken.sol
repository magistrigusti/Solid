// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "../interfaces/IERC721.sol";
import "../ERC721URIStorage.sol";
import "../ERC721Enumerable.sol";

contract DomToken is  ERC721 {
  address public owner;
  uint currentTokenId;

  constructor() ERC721("Dominum", "DOM") {
    owner = msg.sender;
  }

  function safeMint(address to, string calldata tokenId) public {
    require(owner == msg.sender, "not an owner!");

    _safeMint(to, tokenId);
    currentTokenId++;
  }

  function _baseURI() internal pure override returns(string memory) {
    return "ipfs://";
  }
}