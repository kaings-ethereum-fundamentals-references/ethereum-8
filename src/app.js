App = {
    web3Provider: null,
    contracts: {},
    account: '0x0',

    init: () => App.initWeb3(),
    initWeb3: async () =>  {

        await window.ethereum.enable();
        console.log('ethereum..... ', window.ethereum);
        console.log('web3..... ', window.web3, window.web3.currentProvider);

        console.log('Web3..... ', Web3, web3);
        App.web3Provider = window.ethereum;

        web3 = new Web3(App.web3Provider);

        const addr = await web3.eth.getCoinbase();
        console.log('addr..... ', addr, await web3.eth.getAccounts());
    },
    initContract: () => {

    },
    placeBet: () => {

    },
    render: () => {
        
    }
}

// $(function() {
//     $(window).ready(function() {
//         App.init();
//         console.log('test.....');
//     });
// });

window.addEventListener('load', function() {
    console.log('window loaded..... ');
    App.init();
})