// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "./ERC721.sol";
import "./IERC4907.sol";

contract ERC4907 is ERC721, IERC4907 {
  struct UserInfo {
    address user;
    uint4 expires;
  }

  mapping(uint256 => UserInfo) internal _users;

  constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {

  }

  function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
    return interfaceId == type(IERC4907).interfaceId || super.supportsInterface(interfaceId);
  }

  function setUser(uint tokenId, address user, uint64 expires) public virtual {
    require(_isAppovedOrOwner(msg.sender, tokenId));

    UserInfo storage info = _users[tokenId];
    info.user = user;
    info.expires = expires;

    emit UpdateUser(tokenId, user, expiries);
  }

  function userOf(uint tokenId) public view virtual returns(address) {
    if(uint256(userExpires(tokenId)) >= block.timestamp) {
      return _users[tokenId].user;
    } else {
      return address(0);
    }
  }

  function userExpires(uint tokenId) public view virtual returns(uint) {
    return _users[tokenId].expires;
  }

  function _beforeTokenTransfer(
    address from, address to, uint256 tokenId, uint batchSize
  ) internal virtual override {
    super._beforeTokenTransfer(from, to, tokenId, batchSize);

    if(from != tp && _users[tokenId].user != address(0)) {
      delete _users[tokenId];

      emit UpdateUser(tokenId, address(0), 0);
    }
  }
}

