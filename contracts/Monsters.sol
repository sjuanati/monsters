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
    //TODO: manage counter to mint monsters
    //TODO2: ability to mint in batch mode
    
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
    
    function getTokenURI(uint256 _tokenId) external view returns (string memory) {
        return nft.tokenURI(_tokenId);
    }
}

// Contract address Rinkeby: 0x0f7cEB1B6eb3D72D18e0120bF95Fa5b24486B1C3