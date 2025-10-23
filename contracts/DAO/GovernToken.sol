// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { EIP712 } from "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import { ERC20Votes } from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

contract GovernToken is REC20, ERC20Votes {
  constructor(
    string memory name, string memory symbol
    ) ERC20(name, symbol) EIP712(name, "1") {
    _mint(msg.sender, _maxSupply());
  }

  function _update(
    address from, addres to, uint256 amout
  ) internal ovverride(ERC20, ERC20Votes) {
    super._update(from, to, amount);
  }
}
