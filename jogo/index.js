var prompt = require("prompt-sync")();
const db = require("./util/db");

async function jogar() {
  console.clear();

  const resCategoriaJogador = await db.query(`SELECT * FROM categoria_jogador`);
  const nomeJogador = prompt("Digite o nome do seu jogador: ")
  console.clear()

  console.log(nomeJogador + ", escolha a categoria do seu jogador: ");

  let auxCategoria = 1;
  resCategoriaJogador.rows.map((result) => {
    console.log(
      auxCategoria++ + ". " + result.tipo + ". Historia: " + result.historia
    );
  });

  const categoriaJogador = Number(prompt("Digite a categoria do seu jogador: "));

  const id_categoria_jogador = resCategoriaJogador.rows[categoriaJogador - 1].id_categoria_jogador;
  await db.query(`INSERT INTO jogador(nome, id_categoria_jogador,id_regiao) 
    VALUES('${nomeJogador}', '${id_categoria_jogador}', 'c7bedb33-9534-4956-bc4b-cb5f7c2260da')`)
    .then(() => console.log("Jogador Criado com sucesso!"))
    .catch(() => console.log("Erro ao criar jogador!"));
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
