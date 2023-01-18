// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.0;

interface IERC721 {
    function transferFrom(address from, address to, uint256 tokenId) external  ;
}

interface IFlashLoan {
    function takeFlashLoan(uint256 borrowAmount) external;
}

interface IRichGetRicher {
    function win() external payable;
}

contract FlashLoanCaller {

    // The owner of the contract, set to msg.sender upon creation
    address owner;

    // Constructor function to set owner to msg.sender
    constructor(){
        owner = msg.sender;
    }

    // Address of the RichGetRicher contract
    address _addressOfRichGetRicher = 0xF718da03a3C6E7d6BbDD5B250434BBf25bBF26E6;
    // Address of the FlashLoan contract
    address payable _addressOfFlashLoan = payable(0x4CaeA92785e623BC56b011c6f141bb39f8baE94d);
    // Function processLoan will call win() and after will pay borrowed ether back
    function processLoan(uint256 borrowAmount) external payable{
        IRichGetRicher(_addressOfRichGetRicher).win();
        _addressOfFlashLoan.transfer(borrowAmount);

    }
    // Function to call the flash loan by calling the takeFlashLoan function of the FlashLoan contract
    function finisher(uint256 borrowAmount) external{
        IFlashLoan(_addressOfFlashLoan).takeFlashLoan(borrowAmount);
    }
    // Function to handle ERC721 token transfers
    function onERC721Received(address,address,uint256,bytes memory) public virtual  returns(bytes4){
        return this.onERC721Received.selector;
    }
    // Function to transfer an NFT from the contract to the owner
    function transferNFT(uint256 tokenId) public {
        require(msg.sender == owner);
        IERC721(_addressOfRichGetRicher).transferFrom(address(this), owner, tokenId);
    }
    
    receive() external payable {}
}
    


