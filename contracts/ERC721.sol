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

  
}

