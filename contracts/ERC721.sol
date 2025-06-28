// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "./IERC721.sol";
import "./ERC165.sol";
import "./IERC721Receiver.sol";
import "./math/SaveMath.sol";
import "./utils/Address.sol";

contract ERC721 is ERC165, IERC721 {
  using SafeMath for uint256;
  using Address for address;

  bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;

  mapping(uint256 => address) private _tokenOwner;
  mapping(uint256 => address) private _tokenApprovals;
  mapping(address => uint256) private _ownerTokensCount;
  mapping(address => mapping(address => bool)) private _operatorApprovals;

  bytes4 private constant _InterfaceId_ERC721 = 0x80ac58cd;
    /*
   * 0x80ac58cd ===
   *   bytes4(keccak256('balanceOf(address)')) ^
   *   bytes4(keccak256('ownerOf(uint256)')) ^
   *   bytes4(keccak256('approve(address,uint256)')) ^
   *   bytes4(keccak256('getApproved(uint256)')) ^
   *   bytes4(keccak256('setApprovalForAll(address,bool)')) ^
   *   bytes4(keccak256('isApprovedForAll(address,address)')) ^
   *   bytes4(keccak256('transferFrom(address,address,uint256)')) ^
   *   bytes4(keccak256('safeTransferFrom(address,address,uint256)')) ^
   *   bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)'))
   */

   constructor() public {
    _registerInterface(_InterfaceId_ERC721);
   }
}