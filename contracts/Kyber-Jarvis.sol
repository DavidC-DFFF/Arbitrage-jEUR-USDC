// SPDX-License-Identifier: dvdch.eth
pragma solidity ^0.6.0;

//import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/solc-0.6/contracts/access/Ownable.sol";
//import "https://github.com/aave/flashloan-box/blob/master/contracts/aave/FlashLoanSimpleReceiverBase.sol";
import "https://github.com/aave/flashloan-box/blob/master/contracts/aave/FlashLoanReceiverBase.sol";
import "https://github.com/aave/flashloan-box/blob/master/contracts/aave/ILendingPoolAddressesProvider.sol";
import "https://github.com/aave/flashloan-box/blob/master/contracts/aave/ILendingPool.sol";

contract arbitragejeur is Ownable, FlashLoanReceiverBase {
    address recipientWallet;

    constructor(address _addressProvider)
        public
        FlashLoanReceiverBase(_addressProvider)
    {}

    function executeOperation(
        address _asset,
        uint256 _amount,
        uint256 _fee,
        bytes calldata _params
    ) external override {
        require(
            _amount <= getBalanceInternal(
                address(this),
                _asset),
                "Invalid balance, was the flashLoan successful?"
        );

        //
        // Your logic goes here.
        // !! Ensure that *this contract* has enough of `_reserve` funds to payback the `_fee` !!
        //

        uint256 amountOwed = _amount.add(_fee);
        IERC20(_asset).approve(address(addressesProvider), amountOwed);
        transferFundsBackToPoolInternal(_asset, amountOwed);
    }

    //******************
    // Your contract should call the flashLoan() function of the LendingPool
    //******************
    function RequestFlashloan()
        public
        /*address receiver, address asset, uint256 amount, bytes memory params*/
        onlyOwner
    {
        // Flash Loan of 1000 DAI

        address receiver = address(this); // Can also be a separate contract
        address asset = 0xDF1742fE5b0bFc12331D8EAec6b478DfDbD31464; // Dai
        uint256 amount = 1000 * 1e18;

        // If no params are needed, use an empty params:
        bytes memory params = "";
        // Else encode the params like below (bytes encoded param of type `address` and `uint`)
        // bytes memory params = abi.encode(address(this), 1234);

        ILendingPool lendingPool = ILendingPool(
            addressesProvider.getLendingPool()
        );
        lendingPool.flashLoan(
            receiver,
            asset,
            amount,
            params);
    }
}
