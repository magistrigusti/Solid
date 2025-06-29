// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "./IERC721.sol";
import "./IERC721Metadata.sol";
import "./ERC165.sol";
import "./Strings.sol";
import "./IERC721Receiver.sol";

contract ERC721 is ERC165, IERC721, IERC721Metadata {
  using String for uint256;

  string private _name;
  string private _symbol;

  mapping(uint => address) private _owners;
  mapping(address => uint) private _balances;
  mapping(uint => address) private _tokenApprovals;
  mapping(address => mapping(address => bool)) private _operatorApprovals;

  constructor(string memory name_, string memory symbol_) {
    _name = name_;
    _symbol = symbol_;
  }

  function supportsInterface(bytes4 interfaceId) public view virtual overide(ERC165, IERC165) returns(bool) {
    return interfaceId == type(IERC721).interfaceId ||
      interfaceId == type(IERC721Metadata).interfaceId ||
      super.supportsInterface(interfaceId);
  }

  function balanceOf (address owner) public view virtual returns (uint256) {
    require(owner != address(0));

    return _balances[owner];
  }

  function ownerOf (uint256 tokenId) public view virtual returns (address) {
    address owner = _ownerOf(tokenId);
    require(owner != address(0), "tokenID is invalid");
    return owner;
  }

  function name() external view virtual returns(string memory) {
    return _name;
  }

  function symbol() external view virtual returns(string memory) {
    return _symbol;
  }

  function tokenURI(uint256 tokenId) external view virtual returns(string memory) {
    _requireMinted(tokenId);

    string memory baseURI = _baseURI();

    return bytes(baseURI).length > 0 ?
      string(abi.encodePacked(baseURI, tokenId.toString())) :
      "";
  }

  function _baseURI() internal view virtual returns(string memory) {
    return "";
  }

  function approve(address to, uint256 tokenId) external virtual {
    address owner = ownerOf(tokenId);
    require( to != owner );

    require(msg.sender == owner || isApprovedForAll(owner, msg.sender));

    _approve(to, tokenId);
  }

  function getApproved(uitn256 tokenId) public view virtual returns (address) {
    _requireMinted(tokenId);

    return _tokenApprovals[tokenId];
  }

  function setApprovalForAll(address operator, bool approved) external virtual {
    _setApprovalForAll(msg.sender, operator, approved);
  }

  function isApprovedForAll(address owner, address operator) public view virtual returns(bool) {
    return _operatorApprovals[owner][operator];
  }

  function transferFrom(address from, address to, uint256 tokenId) external virtual {
    require(_isApprovedOrOwner(msg.sender, tokenId));

    _transfer(from, to, tokenId);
  }

  function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public virtual {
    require(_isApprovedOrOwer(msg.sender, tokenId));

    _safeTransfer(from, to, tokenId, data);
  }

  function _safeTransfer(address from, address to, uint256 tokenId, bytes memory data) internal virtual {
    _transfer(from, to, tokenId);

    require(_checkOnERC721Received(from, to, tokenId, data));
  }

  function _ownerOf(uint tokenId) internal view virtual returns (address) {
    return _owners(tokenId);
  }

  function _exists(uint256 tokenId) internal view virtual returns(bool) {
    return _ownerOd(tokenId) != address(0);
  }
  
}

