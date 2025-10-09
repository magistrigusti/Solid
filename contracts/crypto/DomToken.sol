// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "../interfaces/IERC721.sol";
import "../ERC721URIStorage.sol";
import "./ERC721Enumerable.sol";

contract DomToken is  ERC721, ERC721Enumerable, ERC721URIStorage {
  address public owner;
  uint currentTokenId;

  constructor() ERC721("Dominum", "DOM") {
    owner = msg.sender;
  }

  function safeMint(address to, string calldata tokenId) public {
    require(owner == msg.sender, "not an owner!");

    _safeMint(to, currentTokenId);
    _setTokenURI(currentToken, tokenId);
    currentTokenId++;
  }

  function supportsInterface(bytes4 interfaceId)
    public view
    override(ERC721, ERC721Enumerable)
    returns (bool)
  {
    return super.supportsInterface(interfaceId);
  }

  function _baseURI() internal pure override returns(string memory) {
    return "ipfs://";
  }

  function _burn(uint tokenId) internal override(ERC721, ERC721URIStorage) {
    super._burn(tokenId);
  }

  function tokenURI(
    uint tokenId
  ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
    return super.tokenURI(tokenId);
  }

  function _beforeTokenTransfer(address from, address to, uint256 tokenId)
    internal override (ERC721, ERC721Enumerable) 
  {
    super._beforeTokenTransfer(from, to, tokenId);
  }
}