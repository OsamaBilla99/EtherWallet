// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract EtherWallet {
    // address er en type som inneholder en ethereum addresse
    // Kun addresser som er deklarert som payable kan motta Ether
    // Solidity compiler auto-genererer getter functions for public variabler
    address payable public owner;

    // constructors kjøres kun når kontrakten blir laget
    constructor() {
        // msg er en global variabel som inneholder attributter tilknyttet brukeren som kaller på funksjonen
        // msg.sender henter ethereum adressen til brukeren
        // ettersom at owner er payable, så må vi sette msg.sender også som payable
        owner = payable(msg.sender);
    }

    // receive er en innebygd funksjon
    // external tillater funksjonen å bli tilkalt av andre smart contracts eller third party applications
    receive() external payable {}

    function withdraw(uint _amount) external {
        require(msg.sender == owner, "Only the owner can call this function.");
        // transfer er innebygd funksjon som tillater sikker overføring av ether
        payable(msg.sender).transfer(_amount);
    }

    // view begrenser funksjonen til kun å lese innhold fra nettverket men kan ikke gjøre endringer
    // read only funksjon
    function getBalance() external view returns (uint) {
        // objektet this refererer til denne smart kontrakten
        // .balance er en attributt av address og returnerer adressens balanse i Wei
        return address(this).balance;
    }

}