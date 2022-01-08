// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// openZeppelin Contracts
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

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
    string[] frontends = ["React", "Angular", "Vue", "Svelete", "Flutter"];
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
        uint256 timestamp,
        uint256 tokenId,
        string[] memory words
    ) public pure returns (string memory) {
        uint256 rand = random(
            string(
                abi.encodePacked(
                    "SUGGESTIONS",
                    Strings.toString(tokenId * words.length * timestamp)
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
            block.timestamp,
            newItemId,
            backends
        );
        string memory frontend = getRandomWords(
            block.timestamp,
            newItemId,
            frontends
        );
        string memory database = getRandomWords(
            block.timestamp,
            newItemId,
            databases
        );
        string memory finalSvg = string(
            abi.encodePacked(
                baseSvg,
                backend,
                frontend,
                database,
                "</text></svg>"
            )
        );
        console.log("data:image/svg+xml;base64,%s", finalSvg);

        // Actually mint the NFT to the sender using msg.sender
        _safeMint(msg.sender, newItemId);

        // set the NFTs data.
        _setTokenURI(
            newItemId,
            "data:application/json;base64,ewogICAgIm5hbWUiOiAiRXBpY0xvcmRIYW1idXJnZXIiLAogICAgImRlc2NyaXB0aW9uIjogIkFuIE5GVCBmcm9tIGhpZ2hseSBhY2NsYWltZWQgc3F1YXJlIGNvbGxlY3Rpb24iLAogICAgImltYWdlIjoiZGF0YTppbWFnZS9zdmcreG1sO2Jhc2U2NCxQSE4yWnlCNGJXeHVjejBpYUhSMGNEb3ZMM2QzZHk1M015NXZjbWN2TWpBd01DOXpkbWNpSUhCeVpYTmxjblpsUVhOd1pXTjBVbUYwYVc4OUluaE5hVzVaVFdsdUlHMWxaWFFpSUhacFpYZENiM2c5SWpBZ01DQXpOVEFnTXpVd0lqNEtJQ0FnSUR4emRIbHNaVDR1WW1GelpTQjdJR1pwYkd3NklIZG9hWFJsT3lCbWIyNTBMV1poYldsc2VUb2djMlZ5YVdZN0lHWnZiblF0YzJsNlpUb2dNVFJ3ZURzZ2ZUd3ZjM1I1YkdVK0NpQWdJQ0E4Y21WamRDQjNhV1IwYUQwaU1UQXdKU0lnYUdWcFoyaDBQU0l4TURBbElpQm1hV3hzUFNKaWJHRmpheUlnTHo0S0lDQWdJRHgwWlhoMElIZzlJalV3SlNJZ2VUMGlOVEFsSWlCamJHRnpjejBpWW1GelpTSWdaRzl0YVc1aGJuUXRZbUZ6Wld4cGJtVTlJbTFwWkdSc1pTSWdkR1Y0ZEMxaGJtTm9iM0k5SW0xcFpHUnNaU0krUlhCcFkweHZjbVJJWVcxaWRYSm5aWEk4TDNSbGVIUStDand2YzNablBnPT0iCn0="
        );

        console.log(
            "An NFT w/ ID %s hasn been minted to %s",
            newItemId,
            msg.sender
        );

        // Increment the tokenIds counter for the next NFT to be minted.
        _tokenIds.increment();
    }
}
