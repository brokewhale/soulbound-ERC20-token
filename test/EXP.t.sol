// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "../lib/forge-std/src/Test.sol";
import "../src/EXP.sol";

contract EXPTest is Test {
    EXP internal exp;
    error NotAuthorized();
    error InsufficientBalance();
    error NotAllowed();

    event Transfer(address indexed from, address indexed to, uint256 value);
    address minter = vm.addr(31337);
    address degenAddr = vm.addr(317);

    uint256 amount;

    function setUp() public {
        exp = new EXP();
        amount = 100 * 10**exp.decimals();
    }

    function testExample() public {
        assertTrue(true);
    }

    function testSetApprovedMinter() public {
        exp.setApprovedMinter(minter, true);
        assertTrue(exp.admins(minter));
    }

    function testFailSetApprovedMinter() public {
        vm.startPrank(minter, minter);
        exp.setApprovedMinter(degenAddr, true);
    }

    function testMint() public {
        exp.mint(minter, amount);
        assertEq(exp.balanceOf(minter), amount);
    }

    function testFailMint() public {
        vm.startPrank(minter, minter);
        exp.mint(degenAddr, amount);
    }

    function testFullMint() public {
        exp.setApprovedMinter(minter, true);
        assertTrue(exp.admins(minter));

        vm.startPrank(minter, minter);
        vm.expectEmit(true, true, false, true);
        emit Transfer(address(0), minter, amount);
        exp.mint(minter, amount);
        assertEq(exp.balanceOf(minter), amount);
        vm.stopPrank();

        vm.startPrank(degenAddr, degenAddr);
        vm.expectRevert(NotAuthorized.selector);
        exp.mint(minter, amount);
    }

    function testBurn() public {
        exp.setApprovedMinter(minter, true);
        assertTrue(exp.admins(minter));
        vm.startPrank(minter, minter);
        exp.mint(minter, amount);
        assertEq(exp.balanceOf(minter), amount);
        vm.expectEmit(true, true, false, true);
        emit Transfer(minter, address(0), amount);
        exp.burn(amount);
        assertEq(exp.balanceOf(minter), 0);

        vm.expectRevert(InsufficientBalance.selector);
        exp.burn(amount);
    }

    function testApprove() public {
        vm.expectRevert(NotAllowed.selector);
        exp.approve(msg.sender, amount);
    }

    function testTransferFrom() public {
        vm.expectRevert(NotAllowed.selector);
        exp.transferFrom(msg.sender, degenAddr, amount);
        assertEq(exp.balanceOf(degenAddr), 0);
    }

    function testTransfer() public {
        vm.expectRevert(NotAllowed.selector);
        exp.transfer(degenAddr, amount);
        assertEq(exp.balanceOf(degenAddr), 0);
    }
}
