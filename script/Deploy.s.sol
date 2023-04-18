// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import {LlamaETHRecovery} from "src/LlamaETHRecovery.sol";

contract DeployScript is Script {
    address private constant TARGET_CONTRACT_ADDRESS =
        0x30f24884f7d744F080187917DbF81C08C2DB582e;
    address payable private constant TREASURY =
        payable(0x73Eb240a06f0e0747C698A219462059be6AacCc8);

    function run() public {
        // NOTE: Set PRIVATE_KEY env var before running script
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        LlamaETHRecovery recovery = new LlamaETHRecovery(TREASURY);

        if (address(recovery) == TARGET_CONTRACT_ADDRESS) {
            recovery.recover();
        }

        vm.stopBroadcast();
    }
}
