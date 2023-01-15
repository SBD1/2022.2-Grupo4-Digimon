const db = require('./util/db');

function main() {
    console.log("BEM VINDO AO DIGIMON GAME");
    console.log(); // colocar a historia do game

    console.log("Conectando ao banco de dados...");
    db;
    console.log("Conectado com sucesso!");
}

main();