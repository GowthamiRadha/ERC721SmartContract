// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyContract is ERC721, Ownable {
    
    //Variables to store the name and symbol of the ERC721 token
    string public erc721TokenName = "XXXXXXX";
    string public erc721TokenSymbol = "YYYYYY";

    //New instance of the Counters.Counter struct to keep track of token IDs, starting at 0
    using Counters for Counters.Counter;
    Counters.Counter tokenIdsCounter;
    using Strings for uint256;
    //Mapping to associate each token ID with its unique metadata URI
    mapping(uint256 => string) _tokenURIs;


    constructor() ERC721(erc721TokenName,erc721TokenSymbol) {}
    
    // Overrides the name function of the ERC721 contract to return the name of the specific token
    function name() public override view returns (string memory) {
        return erc721TokenName;
    }
    
    // Overrides the symbol function of the ERC721 contract to return the name of the specific token
    function symbol() public override view returns (string memory) {
        return erc721TokenSymbol;
    }

    function _setTokenURI(uint256 tokenId, string memory uri) internal {
        _tokenURIs[tokenId] = uri;
    }
    
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory)
    {
       require(_exists(tokenId));
       string memory uri = _tokenURIs[tokenId];
       return uri;
    }

    // Function to mint a new token and associate it with the given metadata URI
    function mint(
        address  to, 
        string memory uri
    )public returns(uint256) {
        uint256 currTokenId = tokenIdsCounter.current();
        _mint(to, currTokenId);
        _setTokenURI(currTokenId, uri);
        tokenIdsCounter.increment();
        return currTokenId;
    }
}