

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
contract Danantiri {
    enum ProgramStatus { INACTIVE, REGISTERED, ALLOCATED }
    struct Program {
        uint256 id;
        string name;
        uint256 target;
        string desc;
        address pic;
        ProgramStatus status;
        uint256 allocated;
    }
    struct History {
        uint256 timestamp;
        string history;
        uint256 amount;
    }
    address public owner;
    Program[] public programs;
    uint256 public totalManagedFund;
    uint256 public totalAllocated;
    mapping(uint256 => History[]) public programHistories;
}