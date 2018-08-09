pragma solidity ^0.4.24;

import "..token.sol"

contract XXXToken is MintableToken, BurnableToken {
  // Coin Properties
    string public name = "XXXtoken";
    string public symbol = "XXX";
    uint256 public decimals = 18;

  // Special propeties
    bool public tradingStarted = false;

  /**
  * @dev modifier that throws if trading has not started yet
   */
    modifier hasStartedTrading() {
        require(tradingStarted);
        _;
    }

  /**
  * @dev Allows the owner to enable the trading. This can not be undone
  */
    function startTrading() public onlyOwner {
        tradingStarted = true;
    }

  /**
  * @dev Allows anyone to transfer the Change tokens once trading has started
  * @param _to the recipient address of the tokens.
  * @param _value number of tokens to be transfered.
   */
    function transfer(address _to, uint _value) hasStartedTrading public returns (bool) {
        return super.transfer(_to, _value);
    }

  /**
  * @dev Allows anyone to transfer the Change tokens once trading has started
  * @param _from address The address which you want to send tokens from
  * @param _to address The address which you want to transfer to
  * @param _value uint the amout of tokens to be transfered
   */
    function transferFrom(address _from, address _to, uint _value) hasStartedTrading public returns (bool) {
        return super.transferFrom(_from, _to, _value);
    }

    function emergencyERC20Drain( ERC20 oddToken, uint amount ) public {
        oddToken.transfer(owner, amount);
    }
}