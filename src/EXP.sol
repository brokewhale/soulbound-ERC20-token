// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EXP is ERC20, Ownable {
    bool constant isSoulbound = true;
    error NotAuthorized();
    error InsufficientBalance();
    error NotAllowed();
    event AdminSet(address indexed newAdmin, bool isAdmin);
    mapping(address => bool) public admins;

    constructor() ERC20("SoulboundToken", "EXP") {
        admins[msg.sender] = true;
    }

    modifier onlyAdmin() {
        if (admins[msg.sender] == true) {
            _;
        } else {
            revert NotAuthorized();
        }
    }

    modifier soulbonded() {
        if (isSoulbound == false) {
            _;
        } else {
            revert NotAllowed();
        }
    }

    function setApprovedMinter(address _minter, bool _isAdmin)
        public
        onlyOwner
    {
        admins[_minter] = _isAdmin;
        emit AdminSet(_minter, _isAdmin);
    }

    function mint(address _to, uint256 _amount) public onlyAdmin {
        _mint(_to, _amount);
    }

    function burn(uint256 _amount) public onlyAdmin {
        if (balanceOf(msg.sender) < _amount) revert InsufficientBalance();
        _burn(msg.sender, _amount);
    }

    function approve(address, uint256)
        public
        pure
        override
        soulbonded
        returns (bool)
    {
        return false;
    }

    function transferFrom(
        address,
        address,
        uint256
    ) public pure override soulbonded returns (bool) {
        return false;
    }

    function transfer(address, uint256)
        public
        pure
        override
        soulbonded
        returns (bool)
    {
        return false;
    }
}
