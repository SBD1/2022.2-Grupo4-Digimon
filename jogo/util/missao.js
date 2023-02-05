var prompt = require("prompt-sync")();
const db = require("./db");

const menu = require('../index');
const batalha = require('./batalha');
const digivice = require('./digivice');
const digimon = require('./digimon');

async function interageMissao(jogadorAtualziado, npc) {
    const missao = await getMissao(npc);
    if (missao === null) {
        console.log("npc nao possui missoes");
        // console.clear();
        await menu.movimentacao(jogadorAtualziado);
    }
    console.log(`missao disponivel: ${missao.nome}`);

    //verifica se jogador ja possui essa missao
    const resMissaoJogador = await getMissaoJogador(missao, jogadorAtualziado);

    if (resMissaoJogador === null) {
        console.log("jogador ja esta cadastrado para essa missao.");
        // console.clear();
        await menu.movimentacao(jogadorAtualziado);
    }

    console.log("\nSelecione uma opcao:");
    console.log("1. Aceitar essa missao");
    console.log("2. Negar essa missao");
    const opcao = prompt("Digite a opcao: "); // opcao digitada no terminal

    if (opcao == '1') {
        try {
            // cadastra essa missao ao usuario
            const resMissao = await db.query(`select * from missao where id_npc = '${npc.id_npc}'`);
            await insertMissaoJogador(resMissao.rows[0], jogadorAtualziado);
            const resDigivice = await digivice.getDigivice(jogadorAtualziado);

            const resInstDigimon = await digivice.getInstanciaDigimon(resDigivice);

            let auxDigimon = 1;
            for (const instDigimon of resInstDigimon) {
                console.log(`${auxDigimon++}. ${instDigimon.nome} - nivel: ${instDigimon.nivel} - vida: ${instDigimon.vida} 
                - defesa: ${instDigimon.defesa} - ataque: ${instDigimon.ataque} - velocidade: ${instDigimon.velocidade}`);
            }

            const opcao = prompt("Digite o numero do digimon para batalhar: "); // opcao digitada no terminal
            await batalha.criaBatalha(resInstDigimon[Number(opcao) - 1]);

        } catch (error) {
            console.log(error.stack)
            console.log("erro ao aceitar missao");
        }
    }
}

async function getMissao(npc) {
    try {
        const resMissao = await db.query(`select * from missao where id_npc = '${npc.id_npc}'`);
        return resMissao.rows[0];
    } catch (error) {
        console.log(error.stack);
    }
}

async function getMissaoJogador(missao, jogadorAtualziado) {
    try {
        const resMissaoJogador = await db.query(`select * from missao_jogador where id_missao = '${missao.id_missao}' and id_jogador = '${jogadorAtualziado.id_jogador}'`);
        return resMissaoJogador.rows[0];
    } catch (error) {
        console.log(error.stack);
    }
}

async function insertMissaoJogador(missao, jogadorAtualziado) {
    try {
        await db.query(`insert into missao_jogador(id_missao, id_jogador, concluida) values('${missao.id_missao}', '${jogadorAtualziado.id_jogador}', false)`);
    } catch (error) {
        console.log(error.stack);
    }
}

module.exports = { interageMissao };
