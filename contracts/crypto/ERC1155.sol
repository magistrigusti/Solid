// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "../interfaces/IERC1155MetadataURI.sol";

contract ERC1155 is IERC1155MetadataURI {
  mapping (uint => mapping(address => uint)) private _balances;
  mapping (address => mapping(address => bool)) private _operatorApprovals;
  string private _uri;

  constructor(string memory uri_) {
    _setURI(uri_);
  }

  function supportsInterface(bytes4 interfaceId) public view virtual returns(bool) {
    return 
      interfaceId == type(IERC1155).interfaceId ||
      interfaceId == type(IERC1155MetadataURI).interfaceId ||
      super.supportsInterface(interfaceId);
  }

  function uri(uint) external view virtual returns(string memory) {
    return _uri;
  }

  function balanceOf(address account, uint id) public view virtual returns(uint) {
    require(account != address(0));

    return _balances[id][account];
  }

  function balanceOfBatch(
    address[] calldata accounts,
    uint[] calldata ids
  ) public view returns(uint[] memory batchBalances) {
    require(accounts.length == ids.length);

    uint[] memory batchBalances = new uint[](accounts.length);

    for(uint i = 0; i < accounts.length; ++i) {
      batchBalances[i] = balanceOf(accounts[i], ids[i]);
    }
  }

  function setApprovalForAll(
    address operator, bool approved
  ) external virtual {
    _setApprovalForAll(msg.sender, operator, approved);
  }

  function isApprovedForAll(
    address account, address operator
  ) external view virtual returns(bool) {
    return _operatorApprovals[account][operator];
  }

  function safeTransferFrom(
    address from,
    address to,
    uint id,
    uint amount,
    bytes calldata data
  ) public virtual {
    require(
      from == msg.sender || isApprovedForAll(from, msg.sender)
    );
    
    _safeTransferFrom(from, to, id, amount, data);
  }

  function safeBatchTransferFrom(
    address from,
    address to,
    uint[] calldata ids,
    uint[] calldata amounts,
    bytes calldata data
  ) public virtual {
    require(
      from == msg.sender || isApprovedForAll(from, msg.sender)
    );
    _safeBatchTransferFrom(from, to, ids, amounts, data);
  }

  function _safeTransferFrom(
    address from,
    address to,
    uint id,
    uint amount,
    bytes calldata data
  ) internal virtual {
    require(to != address(0));
    address operator = msg.sender;

    uint[] memory ids = _asSingletonArray(id);
    uint[] memory amounts = _asSingletonArray(amount);
    
    _beforeTokenTransfer(operator, from, to, ids, amounts, data);

    uint fromBalance = _balances[id][from];
    require(fromBalance >= amount);

    _balances[id][from] = fromBalance - amount;
    _balances[id][to] += amount;

    emit TransferSingle(operator, from, to, id, amount);

    _afterTokenTransfer(operator, from, to, ids, amounts, data);

    _doSafeTransferAcceptanceCheck(operator, from, to, id, amount, data);
  }
}