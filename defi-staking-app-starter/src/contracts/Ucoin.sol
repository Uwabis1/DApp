pragma solidity ^0.5.0; 


contract Ucoin {
    string public name = 'Ucoin';
    string public symbol = 'USDU'; 
    uint256 public totalSupply = 1000000000000000000000000; // 1 million tokens
    uint8 public decimals = 18; 
    address public minter;
 

    event Tfer(
        address indexed _from, 
        address indexed _to, 
        uint256 _value
    ); 

    event Apv(
        address indexed _owner, 
        address indexed _spender, 
        uint256 _value 
    ); 



    mapping(address => uint256) public balanceOf; 
    mapping(address =>mapping(address => uint256)) public allowance; 
    mapping(address =>mapping(address => uint256)) public AprovalTime; 


    constructor() public {
        balanceOf[msg.sender] = totalSupply; 
        minter = msg.sender; 
    }


function Transfer(address _to, uint256 _value) public returns(bool success){
    require(_value <= balanceOf[msg.sender]);
    balanceOf[msg.sender] -= _value; 
    balanceOf[_to] += _value; 
    emit Tfer(msg.sender, _to, _value); 
    return true;  
}

function Aprove(address _spender, uint256 _value) public returns(bool success){
    allowance[msg.sender][_spender] = _value;  
    emit Apv(msg.sender, _spender, _value); 
    AprovalTime[msg.sender][_spender] = block.timestamp; 
    return true; 
}

function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
    require(minter == msg.sender, 'You must be the minter'); 
    require(_value > 0 , 'you cant transfer 0 amount');
    require(_value <= balanceOf[_from], 'you can transfer above your available balance'); 
    require(_value <= allowance[_from][msg.sender], 'you can trasnfer above your allowance'); 
    require(AprovalTime[msg.sender][_from] > 0,'you must approve an amount for this transaction first');
    require(block.timestamp > AprovalTime[msg.sender][_from] + 24 hours,'you must wait 24 hours from aprroval time for this transaction to be effective');
    balanceOf[_from]-= _value; 
    balanceOf[_to] += _value; 
    allowance[msg.sender][_from] -= _value; 
    emit Tfer(_from, _to, _value); 
    return true; 
    }
}