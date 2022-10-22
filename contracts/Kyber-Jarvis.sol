// SPDX-License-Identifier: dvdch.eth
pragma solidity ^0.6.0;

//import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/solc-0.6/contracts/access/Ownable.sol";

contract arbitragejeur is Ownable {
    address recipientWallet;
    
    constructor(address _wallet) public {
        recipientWallet = _wallet;
    }
}
