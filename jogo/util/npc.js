var prompt = require("prompt-sync")();
const db = require("./db");

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

async function checkNPCMercador(npc) {
    try {
        const npcMercador = await db.query(`SELECT * FROM mercador WHERE id_npc = '${npc.id_npc}'`);
        // console.log(npcMercador.rows[0]);
        return npcMercador.rows[0];
    } catch (error) {
        console.error(error);
        return null;
    }
}

async function checkNPCCurandeiro(npc) {
    try {
        const npcCurandeiro = await db.query(`SELECT * FROM curandeiro WHERE id_npc = '${npc.id_npc}'`);
        // console.log(npcCurandeiro.rows[0]);
        return npcCurandeiro.rows[0];
    } catch (error) {
        console.error(error);
        return null;
    }
}

async function interagirNPC(npc) {
    try {
        // console.log(npc)
        // tem que criar a interacao com o npc
        const resDialogo = await getDialogoNPC(npc);
        console.log(resDialogo.texto);

        const npcMercador = await checkNPCMercador(npc);
        const npcCurandeiro = await checkNPCCurandeiro(npc);

        if (npc.id_missao !== undefined) {
            console.log("CRIAR A LOGICA DA BATALHA");
        } else if (npcMercador !== undefined) {
            console.log("CRIAR A LOGICA DA LOJA");
        } else if (npcCurandeiro !== undefined) {
            console.log("CRIAR A LOGICA DE CURAR");
        }

        // Menu
        console.log("\nSelecione uma opcao:");
        console.log("1. Continuar");
        console.log("2. Finalizar jogo");

        const opcao = prompt("Digite a opcao: "); // opcao digitada no terminal

        if (opcao === '2') {
            process.exit();
        }

        console.clear();
    } catch (error) {
        console.error(error);
    }
}

module.exports = { getNPCRegiao, getDialogoNPC, interagirNPC }