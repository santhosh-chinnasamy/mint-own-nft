// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// openZeppelin Contracts
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import {Base64} from "./libraries/Base64.sol";

// extending the ERC721 contract

contract MyEpicNFT is ERC721URIStorage {
    // OpenZeppelin Counter to track tokenIds
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // base svg
    string baseSvg =
        "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    // array with random words
    string[] backends = ["Express", "SpringBoot", "Rails", "Django", "Laravel"];
    string[] frontends = [
        "React",
        "Angular",
        "Vue",
        "Svelete",
        "Flutter",
        "ReactNative",
        "Kotlin"
    ];
    string[] databases = [
        "Postgres",
        "Mariadb",
        "Mongodb",
        "Rethinkdb",
        "Cockroach",
        "Casandra",
        "Sqlite"
    ];

    // pass the name of our nft token and its symbol.
    constructor() ERC721("SquareNFT", "SQUARE") {
        console.log("This is my NFT Contract. Whoa!");
    }

    function getRandomWords(
        uint256 tokenId,
        string[] memory words
    ) public pure returns (string memory) {
        uint256 rand = random(
            string(
                abi.encodePacked(
                    "TECH_STACKS",
                    Strings.toString(tokenId)
                )
            )
        );

        rand = rand % words.length;
        return words[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    // A function our user will hit to get their NFT.
    function makeAnEpicNFT() public {
        // get current tokenId, starts at 0.
        uint256 newItemId = _tokenIds.current();

        string memory backend = getRandomWords(
            // block.timestamp,
            newItemId,
            backends
        );
        string memory frontend = getRandomWords(
            // block.timestamp,
            newItemId,
            frontends
        );
        string memory database = getRandomWords(
            // block.timestamp,
            newItemId,
            databases
        );
        string memory combinedWord = string(
            abi.encodePacked(backend, frontend, database)
        );
    console.log(combinedWord);
        string memory finalSvg = string(
            abi.encodePacked(baseSvg, combinedWord, "</text></svg>")
        );

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name":"',
                        combinedWord,
                        '","description": "Collection of random app development tech suggestions',
                        '","image": "data:image/svg+xml;base64,',
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        // Actually mint the NFT to the sender using msg.sender
        _safeMint(msg.sender, newItemId);

        // set the NFTs data.
        _setTokenURI(newItemId, finalTokenUri);

        // Increment the tokenIds counter for the next NFT to be minted.
        _tokenIds.increment();

        console.log(
            "An NFT w/ ID %s hasn been minted to %s",
            newItemId,
            msg.sender
        );
    }
}
