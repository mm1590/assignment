// SPDX-License-Identifier: MIT
pragma solidity >= 0.6.0 < 0.8.11;

contract token{
    string public name = "token";
    string public symbol = "token";
    uint256 public totalSupply = 10000;
    uint8 decimals = 18;

    mapping (address=>uint) public balanceOf;
    mapping(address=>mapping(address=>uint))public allowance;

    event Transfer(address indexed _from ,address indexed _to ,uint _value);
    event Approval(address indexed _owner ,address indexed _spender ,uint _value);

    constructor() public {
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address _to , uint _value)public returns(bool success){
        require((balanceOf[msg.sender]>=_value));
        balanceOf[msg.sender]-=_value;

        balanceOf[_to]+=_value;
        emit Transfer(msg.sender, _to, _value);
        return true ;
 
    }


    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address owner, address buyer,uint numTokens) public returns (bool)
    {
        require(numTokens <= balanceOf[owner]);
        require(numTokens <= allowance[owner][msg.sender]);

        balanceOf[owner]-=numTokens;
        allowance[owner][msg.sender] -=numTokens;
        balanceOf[buyer]+=  numTokens;
        transfer(buyer, numTokens);
        return true;
    }


}


contract smartcontract1 is token{
    
    
    token Token = new token();

    mapping(address => string) public slab;

    function addAmtToSlab(uint amount) public payable returns(uint) {
        if (amount > 400 && amount <= 500) {
           slab[amount] = slab4;
        }
        else
            if (amount > 300 && amount <= 400) {
                 slab[amount] = slab3;
            }
            else 
                if (amount > 200 && amount <= 300) {
                    slab[amount] = slab2;
                }
               else 
                    if (amount > 100 && amount <= 200) {
                        slab[amount] = slab1;
                    }
                    else 
                         if (amount > 0 && amount <= 100) {
                            slab[amount] = slab0;
                        }
            
        }

        
    }

    function amountrequiryreq(address amount) external view returns(string memory){
      return slab[amount];
  }
    
}
