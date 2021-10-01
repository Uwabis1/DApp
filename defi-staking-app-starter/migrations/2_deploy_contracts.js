const Tether = artifacts.require('Tether')
const RWD = artifacts.require('RWD')
const DecentralBank = artifacts.require('DecentralBank')

module.exports = async function deployer(deployer, network, accounts){
    //deploy mock tether contract 
    await deployer.deploy(Tether)
    const tether = await Tether.deployed()

    //deploy RWD contract 
    await deployer.deploy(RWD)
    const rwd = await RWD.deployed()

    //deploy DecentralBank contract 
    await deployer.deploy(DecentralBank, rwd.address, tether.address)
    const decentralBank = await DecentralBank.deployed()


    //transfer all RWD tokens to the decentralBank
    await rwd.transfer(decentralBank.address, '1000000000000000000000000') //1 million

    //distribute 100 tokens to investor 
    //1 signifies the second address on ganache which is d user, customer, or investors address 
    //in index 1
    //while 0 signifies the digital address (our address) of our bank which is on index 0 
    await tether.transfer(accounts[1], '100000000000000000000') //100
};