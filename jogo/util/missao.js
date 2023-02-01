var prompt = require("prompt-sync")();
const db = require("./db");
const menu = require('../index');

async function interageMissao(jogadorAtualziado, npc) {
    console.log("missoes disponiveis abaixo:")
    
    const missao = await getMissao(npc);
    if (missao === null) {
        console.log("npc nao possui missoes");
        console.clear();
        await menu.movimentacao(jogadorAtualziado);
    }

    const resMissaoJogador = await getMissaoJogador(npc, jogadorAtualziado);

    //verifica se jogador ja possui essa missao
    if (resMissaoJogador == null) {
        console.log("jogador ja esta cadastrado para essa missao.");
        console.clear();
        await menu.movimentacao(jogadorAtualziado);
    }

    console.log("\nSelecione uma opcao:");
    console.log("1. Aceitar essa missao");
    console.log("2. Negar essa missao");
    const opcao = prompt("Digite a opcao: "); // opcao digitada no terminal

    if (opcao == '1') {
        try {
            // cadastra essa missao ao usuario
            await insertMissaoJogador(npc, jogadorAtualziado);
            console.log("missao aceita com sucesso!");
            console.log("TEMOS QUE CRIAR A BATALHA AGORA");
        } catch (error) {
            console.log("erro ao aceitar missao");
        }
    }
}

async function getMissao(npc) {
    try {
        const resMissao = await db.query(`select * from missao where id_npc = '${npc.id_npc}'`);
        return resMissao.rows[0];
    } catch {
        return null;
    }
}

async function getMissaoJogador(npc, jogadorAtualziado) {
    try {
        const resMissaoJogador = await db.query(`select * from missao_jogador where id_npc = '${npc.id_npc}' and id_jogador = '${jogadorAtualziado.id_jogador}'`);
        return resMissaoJogador.rows[0];
    } catch {
        return null;
    }
}

async function insertMissaoJogador(npc, jogadorAtualziado) {
    try {
        await db.query(`insert into missao_jogador(id_npc, id_jogador, concluido) values('${npc.id_npc}',''${jogadorAtualziado.id_jogador}', false`);
    } catch {
        return null;
    }
}

module.exports = { interageMissao };
