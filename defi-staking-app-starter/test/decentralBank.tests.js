const RWD = artifacts.require('RWD')
const Tether = artifacts.require('Tether')
const DecentralBank = artifacts.require('DecentralBank')

require('chai')
.use(require('chai-as-promised'))
.should()


contract('DecentralBank',([owner, customer]) => {
    let tether, rwd, decentralBank


    //web3.utils.toWei helps convert 1000000 to 1000000000000000000000 in wie 
    // we can write and call the below function to enable us convert directly instead
    // of always writting so many zeros in our code
    function tokens(number) {
        return web3.utils.toWei(number, 'ether')
    }

    before(async () => {
        // test load contracts 
        tether = await Tether.new()
        rwd = await RWD.new()
        decentralBank = await DecentralBank.new(rwd.address, tether.address)

        //test to c that we tranfer all tokens to DecentralBank (1 million)
        await rwd.transfer(decentralBank.address, tokens('1000000'))

        //tes to c that we transfer a 100 mock Tehter tokens to investor
        await tether.transfer(customer, tokens('100'), {from: owner})
    })


    describe('Mock Tether Deployment', async() =>{
        it('match name successfully', async() => {
            const name = await tether.name()
            assert.equal(name, 'Mock Tether Token')
        })
    })

    describe('Mock RWD Deployment', async() =>{
        it('match name successfully', async() => {
            const name = await rwd.name()
            assert.equal(name, 'Reward Token')
        })

        it('match symbol successfully', async() => {
            const symbol = await rwd.symbol()
            assert.equal(symbol, 'RwD')
        })

    })

    describe('Decentral Bank Deployment', async() =>{
        it('match name successfully', async() => {
            const name = await decentralBank.name()
            assert.equal(name, 'Decentral Bank')
        })

        it('contract has tokens', async() => {
            // no need to put with the above lets cos we use this only once
            let balance = await rwd.balanceOf(decentralBank.address)
            assert.equal(balance, tokens('1000000'))
        })

    })
    
})

