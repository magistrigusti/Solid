// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

abstract contract Pausable {
  bool private _paused;

  event paused(address account);
  event Unpaused(address account);

  modifier whenNotPaused() {
    _requireNotPaused();
    _;
  }

  modifier whenPaused() {
    _requirePaused();
    _;
  }

  constructor() {
    _paused = false;
  }

  function paused() public view virtual returns(bool) {
    return _paused;
  }

  function _requireNotPaused() internal view virtual {
    require(!paused());
  }

  function _requirePaused() internal view virtual {
    require(paused());
  }

  function _pause() internal virtual whenNotPaused {
    _paused = true;
    emit Paused(msg.sender);
  }

  function _unpaused() internal virtual whenPaused {
    _paused = false;
    emit Unpaused(msg.sender);
  }
}