// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "./NFT.sol";
import "./access/Ownable.sol";
import "./token/ERC721/ERC721.sol";

/**
 * @title   Monsters
 * @notice  xxxxx
 */
contract Monsters is Ownable {
    NFT public nft;

    constructor(string memory _name, string memory _symbol) {
        nft = new NFT(_name, _symbol);
    }

    function mint(
        address _to,
        uint256 _tokenId,
        string memory _tokenURI
    ) external onlyOwner() {
        nft.mint(_to, _tokenId, _tokenURI);
    }

    // For testing
    function burn(uint256 _tokenId) external onlyOwner() {
        nft.burn(_tokenId);
    }

    function setBaseURI(string memory _baseURI) external onlyOwner() {
        nft.setBaseURI(_baseURI);
    }

    function baseTokenURI() external view returns (string memory) {
        return nft.baseTokenURI();
    }

    function tokenURI(uint256 _tokenId) external view returns (string memory) {
        return nft.tokenURI(_tokenId);
    }
}

// Contract address Rinkeby: 0xe7f9fD99B63fBB53148b4963d24c5bF251BE430d

/*
// Cranc
https://storage.googleapis.com/opensea-prod.appspot.com/creature/50.png
https://storage.googleapis.com/opensea-prod.appspot.com/creature/51.png

*/