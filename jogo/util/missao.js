var prompt = require("prompt-sync")();
const { Console } = require("console");
const db = require("./db");

async function missaoNpc(jogadorAtualziado, npc){
    console.log("missoes disponiveis abaixo:")
    const missao = await db.query(`select * from missao where id_npc = '${npc.id_npc}'`)
    if(missao == null){
        return console.log("npc nao possui missoes")
    }
    console.log(missao)
    
    const findMissaoJogador = await db.query(`select * from missao_jogador where id_npc = '${npc.id_npc}' and id_jogador = '${jogadorAtualziado.id_jogador}'`)


    //verifica se jogador ja possui essa missao
    if(findMissaoJogador == null){
        return console.log("jogador ja esta cadastrado para essa missao.")
    }
    console.log("\nSelecione uma opcao:");
    console.log("1. Aceitar essa missao");
    console.log("2. Negar essa missao");

    const opcao = prompt("Digite a opcao: "); // opcao digitada no terminal
    if(opcao == '1'){
        try {
            const getMissao = await db.query(`insert into missao_jogador(id_npc, id_jogador, concluido) values('${npc.id_npc}',''${jogadorAtualziado.id_jogador}', false`);
            console.log("missao aceita com sucesso!")
        } catch (error) {
            console.log("erro ao aceitar missao")
        }
    }

    //cadastra essa missao ao usuario
}

module.exports = { missaoNpc };
