//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

import './RWD.sol'; 
import './Tether.sol'; 

contract DecentralBank {
    string public name = 'Decentral Bank'; 
    address public owner; 
    Tether public tether; 
    RWD public rwd; 

    //setup an array that will keep track of the stakers/ address 
    address[] public stakers; 

    mapping(address => uint) public stakingBalance; 
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;


    constructor(RWD _rwd, Tether _tether)  {
        rwd = _rwd; 
        tether = _tether; 
    }

    //staking function
    function depositTokens(uint _amount )public {
        //require stakig amount to be greater than zero 
        require(_amount > 0,'amount cannot be zero');

        //transfer tether tokens to this contract address for staking
        tether.transferFrom(msg.sender, address(this), _amount);

        //update staking Balance
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount; 

        if (!hasStaked[msg.sender]) {
            stakers.push(msg.sender); 
        }

        //Update staking Banalce 
        isStaking[msg.sender] = true; 
        hasStaked[msg.sender] = true; 
    
    }


}