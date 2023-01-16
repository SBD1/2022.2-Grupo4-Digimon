var prompt = require('prompt-sync')();
const db = require('./util/db');

async function jogar() {
    console.clear();    

    //const nomeJogador = prompt("Digite o nome do seu jogar: ");

    const res = await db.query(`SELECT * FROM categoria_jogador`);
    console.log(res);
    console.log("Selecione a categoria do seu jogador: ");
    console.log("1. ");
    console.log("2. ");
    console.log("3. ");
    //const categoriaJogador = prompt("Digite a categoria do seu jogador: ");
}

async function conectarBanco() {
    try {
        console.log("Conectando ao banco de dados...");
        await db.connect();
        console.log("Conectado com sucesso!");
    } catch (error) {
        // console.log(error);
        console.log("Erro ao conectar ao banco!");
    }
}

async function main() {
    console.log("BEM VINDO AO DIGIMON GAME");
    console.log(); // colocar a historia do game
    
    await conectarBanco();

    // Menu
    console.log("\nSelecione uma opcao para comecar:");
    console.log("1. Jogar");
    console.log("2. Sair");
    
    const opcao = prompt("Digite a opcao: "); // opcao digitada no terminal
    console.log(opcao);

    switch (opcao) {
        case '1':
            await jogar();
            break;
        case '2':
            process.exit();
        default:
            console.clear();
            console.log("Opção inválida!\n");
            main();
            break;
    }
}

main();