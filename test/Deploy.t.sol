// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import {SafeTransferLib} from "solmate/utils/SafeTransferLib.sol";
import "../src/Counter.sol";

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

contract DeployTest is Test {
    using SafeTransferLib for address payable;

    address private constant DEPLOYER =
        0xeaCA0627C546f14FB78502e6371142931a306791;
    address private constant TARGET_CONTRACT_ADDRESS =
        0x30f24884f7d744F080187917DbF81C08C2DB582e;
    address private constant TREASURY =
        0x73Eb240a06f0e0747C698A219462059be6AacCc8;

    function testDeploy() external {
        console.log("test");

        vm.deal(DEPLOYER, 100 ether);
        vm.startPrank(DEPLOYER);

        for (uint256 i; i < 49; ) {
            console.log("i", i);

            LlamaETHRecovery recovery = new LlamaETHRecovery(payable(TREASURY));

            if (TARGET_CONTRACT_ADDRESS == address(recovery)) {
                console.log("recovering");
                console.log("balance before", TREASURY.balance);

                recovery.recover();

                console.log("balance after", TREASURY.balance);
            }

            console.log("");

            unchecked {
                ++i;
            }
        }

        vm.stopPrank();
    }
}
