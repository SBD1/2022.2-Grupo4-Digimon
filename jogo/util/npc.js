var prompt = require("prompt-sync")();
const db = require("./db");
const missao = require("./missao");

async function getNPCRegiao(regiao) {
    try {
        const npc = await db.query(`SELECT * FROM npc WHERE id_regiao = '${regiao.id_regiao}'`);
        return npc.rows[0];
    } catch (error) {
        console.error(error);
        return null;
    }
}

async function getDialogoNPC(npc) {
    try {
        const dialogo = await db.query(`SELECT * FROM dialogo WHERE id_npc = '${npc.id_npc}'`);
        // console.log(dialogo.rows[0]);
        return dialogo.rows[0];
    } catch (error) {
        console.error(error);
        return null;
    }
}

function mercadorNPC() {
    console.log("CRIAR LOGICA PARA A LOJA DE ITENS");
}

function curandeiroNPC() {
    console.log("CRIAR LOGICA PARA RESTAURAR A VIDA COMPLETA DO DIGIMON");
}

async function interagirNPC(npc, jogadorAtualziado) {
    try {
        // console.log(npc)
        // tem que criar a interacao com o npc
        const resDialogo = await getDialogoNPC(npc);
        console.log(resDialogo.texto);
        
        // const npcMercador = await checkNPCMercador(npc);
        // const npcCurandeiro = await checkNPCCurandeiro(npc);
        
        
        if (npc.tipo === 'guia') {
            console.log("CRIAR A LOGICA DA MISSAO");
            const missaoNpc = await missao.interageMissao(jogadorAtualziado, npc);
        } 
        
        else if (npc.tipo === 'mercador') {
            console.log("CRIAR A LOGICA DA LOJA");
            mercadorNPC();
        } 
        
        else if (npc.tipo === 'curandeiro') {
            console.log("CRIAR A LOGICA DE CURAR");
            curandeiroNPC();
        }

        // // Menu
        // console.log("\nSelecione uma opcao:");
        // console.log("1. Continuar");
        // console.log("2. Finalizar jogo");

        // const opcao = prompt("Digite a opcao: "); // opcao digitada no terminal

        // if (opcao === '2') {
        //     process.exit();
        // }

        // console.clear();
    } catch (error) {
        console.error(error);
    }
}

module.exports = { getNPCRegiao, getDialogoNPC, interagirNPC }