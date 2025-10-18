// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "./ERC1155.sol";

contract MyToken is ERC1155 {
  address public owner;

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  constructor() ERC1155("http://example.com") {
    owner = msg.sender;
  }

  function setURI(string memory newuri) public onlyOwner {
    _setURI(newuri);
  }

  function mint(
    address account,
    uint id,
    uint amount,
    bytes memory data
  ) public onlyOwner {
    _mint(account, id, amount, data);
  }

  function mintBatch(
    address to,
    uint[] memory ids,
    uint[] memory amounts,
    bytes memory data
  ) public onlyOwner {
    _mintBatch(to, ids, amounts, data);
  }
}