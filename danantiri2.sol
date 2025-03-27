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

    constructor() {
        owner = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == owner, "Only admin can call this function");
        _;
    }

    modifier onlyPIC(uint256 _programId) {
        require(msg.sender == programs[_programId].pic, "Not PIC of this program");
        _;
    }

    event ProgramCreated(uint256 indexed programId, string name, uint256 target, address pic);
    event ProgramUpdated(uint256 indexed programId, string name, string desc, address pic);
    event FundSent(address indexed sender, uint256 amount);
    event FundAllocated(uint256 indexed programId, uint256 amount);
    event FundWithdrawn(uint256 indexed programId, address indexed pic, string history, uint256 amount);

    function createProgram(
        string calldata _name,
        uint256 _target,
        string calldata _desc,
        address _pic
    ) external onlyAdmin
    {
        require(bytes(_name).length > 0, "Invalid name");
        require(_target > 0, "Invalid target");
        require(bytes(_desc).length > 0, "Invalid description");
        require(_pic != address(0), "Invalid PIC");

        Program memory program = Program({
            id: programs.length,
            name: _name,
            target: _target,
            desc: _desc,
            pic: _pic,
            status: ProgramStatus.REGISTERED,
            allocated: 0
        });

        programs.push(program);
        emit ProgramCreated(program.id, program.name, program.target, program.pic);
    }

    function updateProgram(
        uint256 _programId,
        string calldata _name,
        string calldata _desc,
        address _pic
    ) external onlyAdmin
    {
        require(_programId < programs.length, "Invalid program ID");
        require(bytes(_name).length > 0, "Invalid name");
        require(bytes(_desc).length > 0, "Invalid description");
        require(_pic != address(0), "Invalid PIC");

        Program storage program = programs[_programId];
        program.name = _name;
        program.desc = _desc;
        program.pic = _pic;

        emit ProgramUpdated(_programId, _name, _desc, _pic);
    }

    function getAllProgram() external view returns (Program[] memory) {
        return programs;
    }
}