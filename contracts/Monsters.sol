// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "./access/Ownable.sol";
import "./token/ERC721/ERC721.sol";
import "./ProxyRegistry.sol";

/**
 * @title   NFT
 * @notice  xxxxx
 */
contract Monsters is ERC721, Ownable {
    using Strings for uint256;

    // Optional mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;

    // Base URI
    string private _baseURIextended;

    // tokenID counter
    uint256 private _currentTokenId = 1;

    address proxyRegistryAddress;

    constructor(
        string memory _name,
        string memory _symbol,
        address _proxyRegistryAddress
    ) ERC721(_name, _symbol) {
        proxyRegistryAddress = _proxyRegistryAddress;
    }

    function setBaseURI(string memory baseURI_) external onlyOwner() {
        _baseURIextended = baseURI_;
    }

    // Adapted for OpenSea
    function baseTokenURI() external view returns (string memory) {
        return _baseURIextended;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory _tokenURI = _tokenURIs[tokenId];
        string memory base = _baseURI();

        // If there is no base URI, return the token URI.
        if (bytes(base).length == 0) {
            return _tokenURI;
        }
        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI));
        }
        // If there is a baseURI but no tokenURI, concatenate the tokenID to the baseURI.
        return string(abi.encodePacked(base, tokenId.toString()));
    }

    function isApprovedForAll(address owner, address operator)
        public
        view
        override
        returns (bool)
    {
        // Whitelist OpenSea proxy contract for easy trading.
        ProxyRegistry proxyRegistry = ProxyRegistry(proxyRegistryAddress);
        if (address(proxyRegistry.proxies(owner)) == operator) {
            return true;
        }
        return super.isApprovedForAll(owner, operator);
    }

    function mint(address _to) external onlyOwner() {
        _mint(_to, _currentTokenId);
        _setTokenURI(_currentTokenId, _currentTokenId.toString());
        _currentTokenId += 1;
    }

    function burn(uint256 tokenId) external onlyOwner() {
        _burn(tokenId);
    }

    function _setTokenURI(uint256 tokenId, string memory _tokenURI)
        internal
        virtual
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI set of nonexistent token"
        );
        _tokenURIs[tokenId] = _tokenURI;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseURIextended;
    }
}

// base URL :           https://www.bitacoras.io/monsters/
// contract address:    0xf9c0A102662f99D80e60Da0e8ABA94731dbA5f62
// view                 https://testnets.opensea.io/assets/0xf9c0A102662f99D80e60Da0e8ABA94731dbA5f62/1
// test                 https://testnets-api.opensea.io/asset/0xf9c0A102662f99D80e60Da0e8ABA94731dbA5f62/1/validate
// test2                https://api.opensea.io/asset/0xf9c0A102662f99D80e60Da0e8ABA94731dbA5f62/1/validate/
// update               https://testnets-api.opensea.io/api/v1/asset/0xec2dd1e167b36f6cd0a8ec1e5bfb2adf291d9eed/1/?force_update=true
// proxyRegistryAddress
//      rinkeby "0xf57b2c51ded3a29e6891aba85459d600256cf317";
//      mainnet "0xa5409ec958c83c3f309868babaca7c86dcb077c1";
