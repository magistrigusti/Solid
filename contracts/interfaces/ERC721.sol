// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "./IERC721.sol";
import "./IERC721Metadata.sol";
import "../ERC165.sol";
import "../Strings.sol";
import "../IERC721Receiver.sol";

contract ERC721 is IERC721, IERC721Metadata {\
  using Strings for uint;

  string private _name;
  string private _symbol;

  mapping(address => uint) private _balances;
  mapping(uint => address) private _owners;
  mapping(uint => address) private _tokenApprovals;
  mapping(address => mapping(address => bool)) private _operatorApprovals;

  modifier _requireMinted(uint tokeId) {
    require(_exists(tokenId), "not minted!");
    _;
  }

  constructor(string memory name_, string memory symbol_) {
    _name = name_;
    _sybol = symbol_;
  }

  function name() external view returns(string memory) {
    return _name; 
  }

  function symbol() external view returns(string memory) {
    return _symbol;
  }

  function balanceOf(address owner) public view returns(uint) {
    require(owner != address(0), "owner cannot be zerro");

    return _balances[owner];
  }

  function ownerOf(uint tokenId) public view _requiureMinted(tokenId) returns(address) {
    address _owner = _owners[tokenId];
    require(_owner != address(0), "invalid token id");
    
    return _owner[tokenId];
  }

  function approve(address to, uint tokenId) public {
    address _owner = ownerOf(tokenId);

    require(_owner == msg.sender || isApprovedForAll(_owner, msg.sender), "not an owner!");

    require(to != _owner, "cannot approve to self");

    _tokenApprovals[tokenId] = to;

    emit Approvals(_owner, to, tokenId);
  }

  function setApprovalForAll(address operator, bool approved) public {
    require(msg.sender != operator, "cannot approve to self");

    _operatorApprovals[msg.sender][operator] = approved;

    emit ApprovalFo
  }

  function _baseURI() internal view virtual returns(string memory) {
    return "";
  }

  function tokenURI(uint tokenId) external view _requireMinted(tokenId) returns(string memory) {
    string memory baseURI = _baseURI();
    return bytes(baseURI).length > 0 ? 
      string(abi.encodePacked(baseURI, tokenId.toString())) : "";
  }

  function _exists(uint tokenId) internak view Returns(bool) {
    return _owners[tokenId] != address(0);
  }
}

