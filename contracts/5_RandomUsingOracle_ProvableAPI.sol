
// SPDX-License-Identifier: smartcontract201
pragma solidity > 0.6.0 < 0.7.0;

// import "https://github.com/provable-things/ethereum-api/blob/master/provableAPI_0.6.sol";
import "./provableAPI_0.6.sol";

contract RandomUsingOracle is usingProvable {
    
    uint256 constant NUM_RANDOM_BYTES_REQUESTED = 1;
    uint256 public latestNumber;
    address internal _owner;
    
    event LogNewProvableQuery(string description);
    event generatedRandomNumber(uint256 randomNumber);
    event LogProvableQueryResponse(bytes32 queryId, string result, bytes proof);
    
    constructor() public {
        _owner = msg.sender;
    }
    
    function __callback(bytes32 _queryId, string memory _result, bytes memory _proof) public override (usingProvable) {
        require(msg.sender == provable_cbAddress());    
        
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(_result))) % 100;
        latestNumber = randomNumber;
        
        emit LogNewProvableQuery("response..... ");
        emit generatedRandomNumber(randomNumber);
        emit LogProvableQueryResponse(_queryId, _result, _proof);
        emit LogNewProvableQuery("completed..... ");
    }
    
    function update() payable public {
        uint256 QUERY_EXECUTION_DELAY = 0;
        uint256 GAS_FOR_CALLBACK = 200000;
        
        // provable_newRandomDSQuery function returns bytes32 queryId (similar to the 1st arg on __callback)
        bytes32 queryId = provable_newRandomDSQuery(
            QUERY_EXECUTION_DELAY,
            NUM_RANDOM_BYTES_REQUESTED,
            GAS_FOR_CALLBACK
            );
        emit LogNewProvableQuery("Provable query was sent, standing by for the response..... ");
        emit LogProvableQueryResponse(queryId, "", "0x0");
    }
    
    function destroyContract() public returns(bool) {
        emit LogNewProvableQuery("destroying contract..... ");
        selfdestruct(address(uint160(_owner)));
        return true;
    }
}