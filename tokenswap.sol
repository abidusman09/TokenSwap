// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract TokenSwap {
    address public token1Address;
    address public token2Address;
    
    constructor(address _token1Address, address _token2Address) {
        token1Address = _token1Address;
        token2Address = _token2Address;
    }
    
   function swapTokens(address recipient, address tokenFrom, address tokenTo, uint256 amount) public returns (bool) {
    require(IERC20(tokenFrom).balanceOf(msg.sender) >= amount, "Insufficient balance");
    require(IERC20(tokenFrom).transferFrom(msg.sender, address(this), amount), "Transfer failed");

    uint256 exchangeRate = 2; // 2 tokens from tokenFrom = 1 token from tokenTo
    uint256 swapAmount = amount / exchangeRate;

    require(IERC20(tokenTo).balanceOf(address(this)) >= swapAmount, "Insufficient balance");

    // Transfer swapped tokens to recipient
    require(IERC20(tokenTo).transferFrom(address(this), recipient, swapAmount), "Transfer failed");

    return true;
}

}
