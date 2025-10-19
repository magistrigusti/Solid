// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "./ERC1155.sol";

abstract contract ERC1155Supply is {
  mapping(uint => uint) private _totalSupply;

  function totalSupply(uint id) public view virtual returns(uint) {
    return _totalSupply[id];
  }

  function exists(uint id) public view virtual returns(bool) {
    return ERC1155Supply.totalSupply(id) > 0;
  }

  function _beforeTokenTransfer (
    address operator, 
    address from
    address to,
    uint256[] memory ids,
    uint256[] memory amounts,
    bytes memory data
  ) internal whenNotPaused override {
    super._beforeTokenTransfer(operator, from, to, ids, amounts, data);

    if (from == address(0)) {
      for(uint i = 0; i < ids.length; ++i) {
        _totalSupply[ids[i]] += amounts[i];
      }
    }

    if (to == address(0)) {
      for(uint i = 0; i < ids.length; ++i) {
        uint id = ids[i];
        uint amount = amounts[i];
        uint supply = _totalSupply[id];
        require(supply >= amount);
        _totalSupply[id] = supply - amount;
      }
    }
  }
}