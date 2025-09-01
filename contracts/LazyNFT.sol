// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "./ERC721Lazy.sol";

contract LazyNFT is ERC721Lazy {
    constructor(string memory name, string memory symbol) ERC721(name, symbol) ERC721Lazy(name) {}
}