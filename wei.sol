pragma solidity ^0.5.3;

contract EtherUnits {
    uint public OneWei = 1 wei;
    uint public OneEther = 1 ether;

    function testOneWei() public pure returns(bool) {
        return 1 wei == 1;
    }
    function testOneEther() public pure returns(bool) {
        return 1 ether == 1e18 wei;
    }

}