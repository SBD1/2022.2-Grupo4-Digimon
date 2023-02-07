var prompt = require("prompt-sync")();
const db = require("./util/db");

const jogador = require("./util/jogador");
const regiao = require("./util/regiao");
const npc = require("./util/npc");
const { acessaDigivice } = require("./util/digivice");

async function movimentacao(jogadorAtualizado) {
  const resRegiao = await regiao.getRegiao(jogadorAtualizado); // seleciona a regiao atual do jogador
  console.log(`Voce esta na regiao: ${resRegiao.nome}`);
  
  const resNpc = await npc.getNPCRegiao(resRegiao);
  console.log(`Por aqui temos o NPC: ${resNpc.nome}`);
  // Menu
  console.log("\nSelecione uma opcao:\n");
  console.log("1. Mover jogador");
  console.log("2. Interagir com NPC")
  console.log("3. Acessa digivice")
  console.log("4. Finalizar jogo\n")

  let opcao = prompt("Digite a opcao: "); // opcao digitada no terminal
  // console.log(opcao);

  if (opcao === '2') {
    await npc.interagirNPC(resNpc, jogadorAtualizado);
  }

  if (opcao === '3') {
    await acessaDigivice(jogadorAtualizado)
  }
  
  if (opcao === '4') {
    console.log("\nThau Thau, Ate mais!! :)\n")
    process.exit()
  } 

  await movimentacao(await jogador.movimentaJogador(resRegiao, jogadorAtualizado));
}

async function jogar() {
  const jogadorCriado = await jogador.selecionarJogador(); // cria/recupera jogador
  // const resRegiao = await regiao.getRegiao(jogadorCriado); // seleciona a regiao atual do jogador
  // console.log(`Voce esta na regiao: ${resRegiao.nome}`);
  // const jogadorAtualizado = await jogador.movimentaJogador(resRegiao, jogadorCriado); // moviamenta jogador
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
  console.log("Seja Vindo ao Digimon Game!!\n")
  console.log(); // colocar a historia do game

  await conectarBanco();
  console.clear();

  // Menu
  console.log("Seja Vindo ao Digimon Game!!\n")

  console.log("Selecione uma opcao para comecar:\n");
  console.log("1. Jogar");
  console.log("2. Sair\n");

  const opcao = prompt("Digite a opcao: "); // opcao digitada no terminal

  switch (opcao) {
    case "1":
      await jogar();
      break;
    case "2":
      console.log("\nThau Thau, Ate mais :)\n");
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