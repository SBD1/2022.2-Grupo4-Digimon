var prompt = require("prompt-sync")();
const db = require("./db");
const missao = require("./missao");
const digivice = require("./digivice");
const digimon = require("./digimon");

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

async function mercadorNPC(jogadorAtualziado, npc) {
    console.log("CRIAR LOGICA PARA A LOJA DE ITENS");
}

async function curandeiroNPC(jogadorAtualziado) {
    const resDigivice = await digivice.getDigivice(jogadorAtualziado);
    const resInstDigimon = await digivice.getInstanciaDigimon(resDigivice);

    let auxDigimon = 1;
    for (const instDigimon of resInstDigimon) {
        const resDigimon = await digimon.getDigimon(instDigimon);
        console.log(`${auxDigimon++}. ${resDigimon.nome} - vida: ${instDigimon.vida}`);
    }

    const opcao = prompt("Digite o numero do digimon que vc deseja curar: "); // opcao digitada no terminal

    await digimon.curaDigimon(resDigivice, resInstDigimon[Number(opcao)]);
}

async function interagirNPC(npc, jogadorAtualziado) {
    try {

        const resDialogo = await getDialogoNPC(npc);
        console.log(resDialogo.texto);
        
        if (npc.tipo === 'guia') {
            await missao.interageMissao(jogadorAtualziado, npc);
            console.clear();
        } 
        
        else if (npc.tipo === 'mercador') {
            console.log("CRIAR A LOGICA DA LOJA");
            await mercadorNPC(jogadorAtualziado, npc);
            console.clear();
        } 
        
        else if (npc.tipo === 'curandeiro') {
            await curandeiroNPC(jogadorAtualziado);
            console.clear();
        }

    } catch (error) {
        console.log(error.stack);
    }
}

module.exports = { getNPCRegiao, getDialogoNPC, interagirNPC }