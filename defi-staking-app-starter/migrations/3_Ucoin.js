const Ucoin = artifacts.require('Ucoin')

module.exports = async function deployer(deployer){
    await deployer.deploy(Ucoin)
};