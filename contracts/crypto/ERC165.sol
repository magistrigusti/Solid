// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "../interfaces/IERC165.sol";

contract ERC165 is IERC165 {
  function supportsInterface(bytes4 interfaceId) public view virtual returns(bool) {
    return interfaceId == type(IERC165).interfaceId;
  }
}