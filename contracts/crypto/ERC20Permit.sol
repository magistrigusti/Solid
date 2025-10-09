// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "../IERC20Metadata.sol";
import "../interfaces/IERC20Permit.sol";
import "../ERC20.sol";
import "../utils/Counters.sol";
import "./ECDSA.sol";
import "./EIP712.sol";

abstract contract ERC20Permit is ERC20, IERC20Permit, EIP712 {
  using Counter for Counters.Counter;

  mapping(address => Counters.Counter) private _nonces;
  bytes32 private constant _PERMIT_TYPEHASH = keccak256(
    "Permit(address owner, address spender, uint256 value, uint256 nonce, uint256 deadline)"
  );

  constructor(string memory name) EIP712(name, "1") {}
}