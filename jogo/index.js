var prompt = require("prompt-sync")();
const db = require("./util/db");

const jogador = require("./util/jogador");

async function movimentacao(jogadorAtualziado) {
  // Menu
  console.log("\nSelecione uma opcao:");
  console.log("1. Mover jogador");
  console.log("2. Finalizar jogo");

  const opcao = prompt("Digite a opcao: "); // opcao digitada no terminal
  console.log(opcao);

  if (opcao === '2') {
    process.exit();
  } 

  const resRegiao = await jogador.getRegiao(jogadorAtualziado); // seleciona a regiao atual do jogador
  await movimentacao(await jogador.movimentaJogador(resRegiao, jogadorAtualziado));
}

async function jogar() {
  const jogadorCriado = await jogador.selecionarJogador(); // cria/recupera jogador
  const resRegiao = await jogador.getRegiao(jogadorCriado); // seleciona a regiao atual do jogador
  const jogadorAtualziado = await jogador.movimentaJogador(resRegiao, jogadorCriado); // moviamenta jogador
  movimentacao(jogadorAtualziado);
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
  console.clear();

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
