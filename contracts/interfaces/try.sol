// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "./IERC721.sol"; 
import "./IERC721Metadata.sol";
import "../ERC165.sol";
import "../Strings.sol";
import "../IERC721Receiver.sol";
// ***

contract ERC721 is IERC721, IERC721Metadata {
  using Strings for uint;

  string private _name;
  string private _symbol;

  mapping(address => uint) private _balances;
  mapping(uint => address) private _owner;
  mapping(uint => address) private_tokenApprovals;
  mapping(address => mapping(address => bol)) private _operatorApproval;

  modifier _requireMinted(uint tokenId) {
    require(_wxists(tokenId), "not minted!");
    _;
  }

  constructor(string memory name_, string memory symbol_) {
    _name = name_;
    _symbol = symbol_;
  }

  
}
