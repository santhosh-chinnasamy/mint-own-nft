// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// openZeppelin Contracts
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// extending the ERC721 contract

contract MyEpicNFT is ERC721URIStorage {
    // OpenZeppelin Counter to track tokenIds
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // pass the name of our nft token and its symbol.
    constructor() ERC721("SquareNFT", "SQUARE") {
        console.log("This is my NFT Contract. Whoa!");
    }

    // A function our user will hit to get their NFT.
    function makeAnEpicNFT() public {
        // get current tokenId, starts at 0.
        uint256 newItemId = _tokenIds.current();

        // Actually mint the NFT to the sender using msg.sender
        _safeMint(msg.sender, newItemId);

        // set the NFTs data.
        _setTokenURI(newItemId, "https://jsonkeeper.com/b/7Y9V");
        console.log("An NFT w/ ID %s hasn been minted to %s", newItemId, msg.sender);

        // Increment the tokenIds counter for the next NFT to be minted.
        _tokenIds.increment();
    }
}
