var prompt = require("prompt-sync")();
const db = require("./db");

const menu = require("../index");
const batalha = require("./batalha");
const digivice = require("./digivice");
const digimon = require("./digimon");

async function interageMissao(jogadorAtualizado, npc) {
  const missao = await getMissao(npc);
  if (missao === null) {
    console.log("npc nao possui missoes");
    // console.clear();
    await menu.movimentacao(jogadorAtualizado);
  }
  console.log(`Missao disponivel: ${missao.nome}`);

  //verifica se jogador ja possui essa missao
  const resMissaoJogador = await getMissaoJogador(missao, jogadorAtualizado);

  if (resMissaoJogador === null) {
    console.log("jogador ja esta cadastrado para essa missao.");
    // console.clear();
    await menu.movimentacao(jogadorAtualizado);
  }

  console.log("\nSelecione uma opcao:\n");
  console.log("1. Aceitar essa missao");
  console.log("2. Negar essa missao\n");
  const opcao = prompt("Digite a opcao: "); // opcao digitada no terminal

  if (opcao == "1") {
    try {
      //verifica se ja fez essa missao.
      const resultCheckMissao = await checkMissaoFeita(
        missao,
        jogadorAtualizado
      );
      if (resultCheckMissao === undefined) {
        // cadastra essa missao ao usuario

        console.log("Missao Aceita com sucesso!\n");
        await insertMissaoJogador(missao, jogadorAtualizado);
        const resDigivice = await digivice.getDigivice(jogadorAtualizado);

        const resInstDigimon = await digivice.getInstanciaDigimon(resDigivice);

        let auxDigimon = 1;
        for (const instDigimon of resInstDigimon) {
          console.log(`${auxDigimon++}. ${instDigimon.nome} - nivel: ${
            instDigimon.nivel
          } - vida: ${instDigimon.vida} 
                    - defesa: ${instDigimon.defesa} - ataque: ${
            instDigimon.ataque
          } - velocidade: ${instDigimon.velocidade}`);
        }

        const opcao = prompt("Digite o numero do digimon para batalhar: "); // opcao digitada no terminal
        await batalha.criaBatalha(resInstDigimon[Number(opcao) - 1], missao.id_missao);
        await concluiMissaoJogador(missao, jogadorAtualizado);
      }
      else{
        console.log("Usuario ja fez essa missao!!");
        let timeout = setTimeout(() => {
          console.log("Timeout expired");
        }, 100000);
        
        let input = prompt("Pressione 1 para continuar: ");
        if (input === "1") {
          clearTimeout(timeout);
        } 
      }
    } catch (error) {
      console.log(error.stack);
      console.log("erro ao aceitar missao");
    }
  }
}

async function getMissao(npc) {
  try {
    const resMissao = await db.query(
      `select * from missao where id_npc = '${npc.id_npc}'`
    );
    return resMissao.rows[0];
  } catch (error) {
    console.log(error.stack);
  }
}

async function checkMissaoFeita(missao, jogadorAtualizado) {
  try {
    const checkMissaoFeita = await db.query(
      `select * from missao_jogador  where id_missao  = '${missao.id_missao}' and id_jogador = '${jogadorAtualizado.id_jogador}'`
    );
    return checkMissaoFeita.rows[0];
  } catch (error) {
    console.log(error.stack);
  }
}
async function getMissaoJogador(missao, jogadorAtualizado) {
  try {
    const resMissaoJogador = await db.query(
      `select id_missao from missao_jogador where id_missao = '${missao.id_missao}' and id_jogador = '${jogadorAtualizado.id_jogador}'`
    );
    return resMissaoJogador.rows[0];
  } catch (error) {
    console.log(error.stack);
  }
}

async function insertMissaoJogador(missao, jogadorAtualizado) {
  try {
    await db.query(
      `insert into missao_jogador(id_missao, id_jogador, concluida) values('${missao.id_missao}', '${jogadorAtualizado.id_jogador}', false)`
    );
  } catch (error) {
    console.log(error.stack);
  }
}

async function concluiMissaoJogador(missao, jogadorAtualizado) {
  try {
    await db.query(
      `update  missao_jogador set concluida = true where id_missao = '${missao.id_missao}' and id_jogador = '${jogadorAtualizado.id_jogador}'`
    );
  } catch (error) {
    console.log(error.stack);
  }
}
module.exports = { interageMissao };
