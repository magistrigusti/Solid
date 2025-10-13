// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "../interfaces/IERC1155MetadataURI.sol";
import "../interfaces/IERC1155.sol";
import "../interfaces/IERC1155Receiver.sol";
import "./ERC165.sol";

contract ERC1155 is ERC165, IERC115, IERC1155MetadataURI {
  mapping (uint => mapping(adress => uint)) private _balances;
  mapping (address => mapping(address => bool)) private _operatorApprovals;
  string private _uri;

  constructor(string memory uri_) {
    _setURI(uri_);
  }

  function supportsInterface(
    bytes4 interfaceId
  ) public view override(ERC165, IERC165) virtual returns(bool) {
    return
      interfaceId == type(IERC1155).interfaceId ||
      interfaceId == type(IERC1155MetadataURI).interfaceId ||
      super.supportsInterface(interfaceId);
  }

  function uri(uint) external view virtual returns(string memory) {
    return _uri;
  }
}
