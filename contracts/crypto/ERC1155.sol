// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "../interfaces/IERC1155MetadataURI.sol";
import "../interfaces/IERC1155.sol";
import "../interfaces/IERC1155Receiver.sol";
import "./ERC165.sol";

contract ERC1155 is ERC165, IERC1155, IERC1155MetadataURI {
  mapping (uint => mapping(address => uint)) private _balances;
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
  ) public view virtual returns(bool) {
    return _operatorApprovals[account][operator];
  }

  function safeTransferFrom(
    address from,
    address to,
    uint id,
    uint amount,
    bytes calldata data
  ) public virtual {
    require(from == msg.sender || isApprovedForAll(from, msg.sender));
    
    _safeTransferFrom(from, to, id, amount, data);
  }

  function safeBatchTransferFrom(
    address from,
    address to,
    uint[] calldata ids,
    uint[] calldata amounts,
    bytes calldata data
  ) public virtual {
    require(from == msg.sender || isApprovedForAll(from, msg.sender));

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

  function _safeBatchTransferFrom(
    address from, 
    address to,
    uint[] calldata ids,
    uint[] calldata amounts,
    bytes calldata data
  ) internal virtual {
    require(ids.length == amounts.length);
    require(to != address(0));

    address operator = msg.sender;

    _beforeTokenTransfer(operator, from, to, ids, amounts, data);

    for(uint i = 0; i < ids.length; ++i) {
      uint id = ids[i];
      uint amount = amounts[i];
      uint fromBalance = _balances[id][from];
      
      require(fromBalance >= amount);
      _balances[id][from] = fromBalance - amount;
      _balances[id][to] += amount;
    }

    emit TransferBatch(operator, from, to, ids, amounts);
    _afterTokenTransfer(operator, from, to, ids, amounts, data);
    _doSafeBatchTransferAcceptanceCheck(operator, from, to, ids, amounts, data);
  }

  function _setURI(string memory newUri) internal virtual {
    _uri = newUri;
  }

  function _setApprovalForAll(
    address owner,
    address operator,
    bool approved
  ) internal virtual {
    require(owner != operator);

    _operatorApprovals[owner][operator] = approved;
    emit ApprovalForAll(owner, operator, approved);
  }

  function _beforeTokenTransfer(
    address operator,
    address from,
    address to,
    uint[] memory ids,
    uint[] memory amounts,
    bytes memory data
  ) internal virtual {}

  function _afterTokenTransfer(
    address operator,
    address from,
    address to,
    uint[] memory ids,
    uint[] memory amounts,
    bytes memory data
  ) internal virtual {}

  function _doSafeTransferAcceptanceCheck(
    address operator,
    address from,
    address to,
    uint id,
    uint amount,
    bytes memory data
  ) private {
    if (to.code.length > 0) {
      try IERC1155Receiver(to).onERC1155Received(
        operator, from, id, amount, data
      ) returns(bytes4 resp) {
        if (resp != IERC1155Receiver.onERC1155Received.selector) {
          revert("Rejected tokens!");
        }
      } catch Error(string memory reason) {
        revert(reason);
      } catch {
        revert("Non-ERC1155 receiver!");
      }
    }
  }

  function _doSafeBatchTransferAcceptanceCheck(
    address operator,
    address from,
    address to,
    uint[] ids,
    uint[] amounts,
    bytes memory data
  ) private {
    if (to.code.length > 0) {
      try IERC1155Receiver(to).onERC1155BatchReceived(
        operator, from, ids, amounts, data
      ) returns(bytes4 resp) {
        if (resp != IERC1155Receiver.onERC1155BatchReceived.selector) {
          revert("Rejected tokens!");
        }
      } catch Error(string memory reason) {
        revert(reason);
      } catch {
        revert("Non-ERC1155 receiver!");
      }
    }
  }

  function _asSingJettonArray(uint el) private pure returns(uint[] memory result) {
    result = new uint[](1);
    result[0] = el;
  }
}