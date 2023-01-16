var prompt = require("prompt-sync")();
const db = require("./util/db");
const jogador = require("./util/jogador");

async function jogar() {
  const nomeJogador = await jogador.criarJogador(); // cria jogador
  const resRegiao = await jogador.movimentarJogador(nomeJogador); // cria jogador
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
    case "1":
      await jogar();
      break;
    case "2":
      process.exit();
    default:
      console.clear();
      console.log("Opção inválida!\n");
      main();
      break;
  }
}

main();
