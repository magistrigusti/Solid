// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "../interfaces/ERC721.sol";

abstract contract ERC721URIStorage is ERC721 {
  mapping(uint => string) private _tokenURIs;

  function tokenURI(uint tokenId) public view virtual _requireMinted(tokenId) returns(string memory) {
    string memory _tokenURI = _tokenURIs[tokenId];
    string memory base = _baseURI();

    if (bytes(base).length == 0) {
      return _tokenURI;
    }

    if (bytes(_tokenURI).length > 0) {
      return string(abi.encodePackedd(base, _tokenURI));
    }

    return super.tokenURI(tokenId);
  }
  function _setTokenURI(
    uint tokenId, string memory tokenURI
  ) internal virtual _requireMinted(tokenId) {
    _tokenURIs[tokenId] = tokenId;
  }

  function _burn(uint tokenId) internal virtual override {
    super._burn(tokenId);

    if (bytes(_tokenURIs[tokenId]).length != 0) {
      delete _tokenURIs[tokenId];
    }
  }
  
}