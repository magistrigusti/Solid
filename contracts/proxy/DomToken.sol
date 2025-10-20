// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/accetss/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract DomToken is Initializable, ERC20Upgradeable, OwnableUpgradeable {
  function initialize() external initializer {
    __ERC20_init("DomToken", "DOM");
    __Ownable_init();
  }

  function mint(address to, uint amount) external onlyOwner {
    _mint(to, amount);
  }
}