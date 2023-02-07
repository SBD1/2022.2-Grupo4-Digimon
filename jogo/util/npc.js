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

async function mercadorNPC(jogadorAtualizado, npc) {
    console.log("CRIAR LOGICA PARA A LOJA DE ITENS");
}

async function curandeiroNPC(jogadorAtualizado) {
    const resDigivice = await digivice.getDigivice(jogadorAtualizado);
    const resInstDigimon = await digivice.getInstanciaDigimon(resDigivice);

    let auxDigimon = 1;
    for (const instDigimon of resInstDigimon) {
        console.log(`${auxDigimon++}. ${instDigimon.nome} - vida: ${instDigimon.vida}`);
    }

    const opcao = prompt("Digite o numero do digimon que vc deseja curar: "); // opcao digitada no terminal

    await digimon.curaDigimon(resInstDigimon[Number(opcao) - 1]);
}

async function interagirNPC(npc, jogadorAtualizado) {
    try {

        const resDialogo = await getDialogoNPC(npc);
        
        console.clear();
        console.log('\n' + npc.nome + ': \"' + resDialogo.texto + '\"');
        
        if (npc.tipo === 'guia') {
            await missao.interageMissao(jogadorAtualizado, npc);
        } 
        
        else if (npc.tipo === 'mercador') {
            console.log("CRIAR A LOGICA DA LOJA");
            await mercadorNPC(jogadorAtualizado, npc);
        } 
        
        else if (npc.tipo === 'curandeiro') {
            await curandeiroNPC(jogadorAtualizado);
        }

    } catch (error) {
        console.log(error.stack);
    }
}

module.exports = { getNPCRegiao, getDialogoNPC, interagirNPC }