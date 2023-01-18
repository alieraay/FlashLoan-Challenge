//SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.16;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract RichGetRicher is ERC721 {
    address public owner;
    uint256 private _tokenId;
    bool public won = false;

    constructor() ERC721("Rich Get Richer", "RGR") {
        owner = msg.sender;
    }

    function win() external payable {
        require(msg.sender.balance >= 100 ether, "become rich first");
        require(!won, "challenge over");
        won = true;
        _safeMint(msg.sender, _tokenId);
        _tokenId++;
    }

    function setWon(bool state) external {
        require(msg.sender == owner);
        won = state;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireMinted(tokenId);

        return "ipfs://bafkreifoesqir34ubulpjsg5o2zjt4scx2liefrswrqg4cpdua3yvrzlla/";
    }

}
