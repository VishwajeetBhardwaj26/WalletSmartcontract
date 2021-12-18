pragma solidity ^0.8.10;
import "./allowance.sol";
contract SimpleWallet is Allowance{
    event MoneySent(address indexed _beneficiary,uint _amount);
    event MoneyRecived(address indexed _from,uint _amount);
    function withdrawMoney(address payable _to,uint _amount)public ownerOrAllowed(_amount){
        require(_amount<=address(this).balance,"there are no enough funds in the smart contract");
        if(!isOwner()){
            reduceAllowance(msg.sender,_amount);
        }
        emit MoneySent(_to,_amount);
        _to.transfer(_amount);
    }
    function renounceOwnership()public onlyOwner{
        revert("can not renounce owner here");
    }
    fallback() external payable {
        emit MoneyRecived(msg.sender,msg.value);
    }
    
}