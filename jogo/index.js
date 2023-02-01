var prompt = require("prompt-sync")();
const db = require("./util/db");

const jogador = require("./util/jogador");
const regiao = require("./util/regiao");
const npc = require("./util/npc");
const { acessaDigivice } = require("./util/digivice");

async function movimentacao(jogadorAtualziado) {
  const resRegiao = await regiao.getRegiao(jogadorAtualziado); // seleciona a regiao atual do jogador
  console.log(`Voce esta na regiao: ${resRegiao.nome}`);
  
  const resNpc = await npc.getNPCRegiao(resRegiao);
  console.log(`Por aqui temos o NPC: ${resNpc.nome}`);
  // Menu
  console.log("\nSelecione uma opcao:");
  console.log("1. Mover jogador");
  console.log("2. Interagir com NPC")
  console.log("3. Finalizar jogo");
  console.log("4. Acessa digivce");

  let opcao = prompt("Digite a opcao: "); // opcao digitada no terminal
  // console.log(opcao);

  if (opcao === '2') {
    await npc.interagirNPC(resNpc, jogadorAtualziado);
  }

  if (opcao === '3') {
    process.exit();
  }
  
  if (opcao === '4') {
    await acessaDigivice(jogadorAtualziado)
  } 

  await movimentacao(await jogador.movimentaJogador(resRegiao, jogadorAtualziado));
}

async function jogar() {
  const jogadorCriado = await jogador.selecionarJogador(); // cria/recupera jogador
  // const resRegiao = await regiao.getRegiao(jogadorCriado); // seleciona a regiao atual do jogador
  // console.log(`Voce esta na regiao: ${resRegiao.nome}`);
  // const jogadorAtualziado = await jogador.movimentaJogador(resRegiao, jogadorCriado); // moviamenta jogador
  movimentacao(jogadorCriado);
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

exports.movimentacao = movimentacao