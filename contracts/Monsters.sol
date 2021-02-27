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
    /*
    function create(string memory _name, string memory _symbol) external onlyOwner() {
        nft = new NFT(_name, _symbol);
    }
    */
    function mint(address _to, uint256 _tokenId, string memory _tokenURI) external onlyOwner() {
        nft.mint(_to, _tokenId, _tokenURI);
    }
    
    function setBaseURI(string memory _baseURI) external onlyOwner() {
        nft.setBaseURI(_baseURI);
    }
    
    function tokenURI(uint256 _tokenId) external view returns (string memory) {
        return nft.tokenURI(_tokenId);
    }
    
    function baseTokenURI() external view returns (string memory) {
        return nft.baseTokenURI();
    }
}

// Contract address Rinkeby: 0x88719e766Be28ede552CBDC15F7C137eD3833524