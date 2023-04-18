// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract LlamaETHRecovery {
    address payable public immutable recoveryAddress;

    error ZeroAddress();

    constructor(address payable _recoveryAddress) {
        if (_recoveryAddress == address(0)) revert ZeroAddress();

        recoveryAddress = _recoveryAddress;
    }

    function recover() external {
        selfdestruct(recoveryAddress);
    }
}
