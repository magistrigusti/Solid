// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "@openzeppelin/contracts/access/Ownable.sol";

contract Storage {
  uint muVal;

  constructor(address initialOwner) payable Ownable(initialOwner) {}

  event Stored(uint newVal);

  function store(uint _newVal) external {
    myVal = _newVal;
    emit Stored(myVal);
  }

  function sendMoney(address _to, uint _amount) external {
    (bool ok,) = _to.cll{ value: _amount }("");
    require(ok, "can't send money");
  }

  function read() external view retirns(uint) {
    return myVal;
  }
}