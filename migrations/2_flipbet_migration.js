const FlipBet = artifacts.require('FlipBet');

module.exports = function(deployer, network, accounts) {
    deployer.deploy(FlipBet, {value: 10000000000000000, from: accounts[1]});
}