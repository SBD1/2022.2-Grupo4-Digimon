var prompt = require("prompt-sync")();
const db = require("./db");

async function criarJogador() {
  console.clear();

  const resCategoriaJogador = await db.query(`SELECT * FROM categoria_jogador`);
  const nomeJogador = prompt("Digite o nome do seu jogador: ");
  console.clear();

  console.log(nomeJogador + ", escolha a categoria do seu jogador: ");

  let auxCategoria = 1;
  resCategoriaJogador.rows.map((result) => {
    console.log(
      auxCategoria++ + ". " + result.tipo + ". Historia: " + result.historia
    );
  });

  const categoriaJogador = Number(
    prompt("Digite a categoria do seu jogador: ")
  );

  const id_categoria_jogador =  resCategoriaJogador.rows[categoriaJogador - 1].id_categoria_jogador;
  const jogadorCriado = await db.query(
    `INSERT INTO jogador(nome, id_categoria_jogador,id_regiao) 
    VALUES('${nomeJogador}', '${id_categoria_jogador}', 'c7bedb33-9534-4956-bc4b-cb5f7c2260da') RETURNING *`
  ).then((jogadorCriado)=>{
    console.log("jogador criado com sucesso");
    // return jogadorCriado.rows[0];
  }).catch(()=>{
    console.log("erro ao criar jogador!")
  })
  return jogadorCriado;
}

async function getRegiao(jogadorCriado) {
    
    console.log("teste return")

  const resRegiao = await db.query(
    `SELECT * FROM regiao where id_regiao = '${jogadorCriado.id_regiao}'`
  );
  //posicções que o jogador se encontra

  console.log(`${jogadorCriado.nome} esta na regiao ${resRegiao.rows[0].nome}`);
  return resRegiao;
}

async function movimentaJogador(resRegiao,jogadorCriado) {
  let posicao_x = resRegiao.rows[0].eixo_x;
  let posicao_y = resRegiao.rows[0].eixo_y;

  //sabendo para quais lados o jogador pode ir, fazer uma query de select no banco para trazer as regioes as quais ele pode ir
  //aumentando ou diminuindo em 1 o eixo_x ou eixo_uy
  let regiaoDestino;
  console.log("A partir dessa regiao voce pode ir para esses lugares: \n");
  if (esquerda(posicao_x)) {
    regiaoDestino = await db.query(
      `SELECT * FROM public.regiao WHERE (eixo_x = ${
        posicao_x - 1
      })  AND (eixo_y = ${posicao_y})`
    );
    console.log("1)" + regiaoDestino.rows[0].nome);
  }
  if (direita(posicao_x)) {
    regiaoDestino = await db.query(
      `SELECT * FROM public.regiao WHERE (eixo_x = ${
        posicao_x + 1
      })  AND (eixo_y = ${posicao_y})`
    );
    console.log("2)" + regiaoDestino.rows[0].nome);
  }
  if (cima(posicao_y)) {
    regiaoDestino = await db.query(
      `SELECT * FROM public.regiao WHERE (eixo_x = ${posicao_x})  AND (eixo_y = ${
        posicao_y + 1
      })`
    );
    console.log("3)" + regiaoDestino.rows[0].nome);
  }
  if (baixo(posicao_y)) {
    regiaoDestino = await db.query(
      `SELECT * FROM public.regiao WHERE (eixo_x = ${posicao_x})  AND (eixo_y = ${
        posicao_y - 1
      })`
    );
    console.log("4)" + regiaoDestino.rows[0].nome);
  }
  regiaoDestino = prompt("Escolha o numero da sua regiao destino: ");
  switch (regiaoDestino) {
    case "1":
      await movEsq();
      break;
    case "2":
      await movDir();
    case "3":
      await movCima();
    case "4":
      await movBaixo();
    default:
      console.clear();
      console.log("Opção inválida!\n");
      main();
      break;
  }

  //faria uma busca da direção que ele pode ir de acordo com as posições que retornassem true.
}
async function movCima(posicao_y, jogadorCriado) {
  posicao_y++;
}
async function movBaixo(posicao_y, jogadorCriado) {
  posicao_y--;
}
async function movDir(posicao_x, jogadorCriado) {
  posicao_x++;
}
async function movEsq(posicao_x, jogadorCriado) {
  posicao_x--;
}

function direita(posicao_x) {
  if (posicao_x >= 0 && posicao_x <= 2) {
    return true;
  }
  return false;
}
function esquerda(posicao_x) {
  if (posicao_x > 1 && posicao_x <= 3) {
    return true;
  }
  return false;
}
function cima(posicao_y) {
  if (posicao_y >= 0 && posicao_y <= 1) {
    return true;
  }
  return false;
}
function baixo(posicao_y) {
  if (posicao_y >= 2 && posicao_y <= 1) {
    return true;
  }
  return false;
}

module.exports = { criarJogador, movimentaJogador, getRegiao };
