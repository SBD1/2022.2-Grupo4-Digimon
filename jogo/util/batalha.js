const db = require("./db");
var prompt = require("prompt-sync")();

async function criaBatalha(instanciaDigimon, idMissao) {
    try {
        await db.query(`call cria_batalha('${instanciaDigimon.id_instancia_digimon}', '${idMissao}')`);

        let resMonstros = await db.query(`select * from batalha join monstro
        on batalha.id_batalha = monstro.id_batalha 
        join digimon d on d.id_digimon = monstro.id_digimon where batalha.id_instancia_digimon = '${instanciaDigimon.id_instancia_digimon}'`);

        //logicia da batalha
        for (let monstro of resMonstros.rows) {
            console.log(`batalha com o monstro: ${monstro.nome}`);
            await batalha(instanciaDigimon, monstro);
        }

        console.log("vc ganhou!")

        await db.query(`delete from batalha where id_batalha = '${resMonstros.rows[0].id_batalha}'`); // deleta batalha
    } catch (error) {
        console.log(error.stack);
        console.log("falha ao criar batalha");
    }

}

async function batalha(instanciaDigimon, monstro) {
    do {
        console.log(`\nvida atual digimon: ${instanciaDigimon.vida_atual}`);
        console.log(`vida atual monstro: ${monstro.vida_atual}`);

        if (instanciaDigimon.velocidade >= monstro.velocidade) {
            console.log("digimon comeca o duelo");
            await batalhaCaraBate(instanciaDigimon, monstro);
            if (monstro.vida_atual > 0)
                await batalhaMonstroBate(instanciaDigimon, monstro);
            else
                console.log("monstro morreu");
        } else {
            console.log("monstro comeca o duelo");
            await batalhaMonstroBate(instanciaDigimon, monstro);
            if (instanciaDigimon.vida_atual > 0)
                await batalhaCaraBate(instanciaDigimon, monstro);
            else
                console.log("digimon morreu");
        }
    } while (instanciaDigimon.vida_atual > 0 && monstro.vida_atual > 0);
}

async function batalhaCaraBate(instanciaDigimon, monstro) {
    console.log("\nSelecione uma opcao:");
    console.log("1. Atacar");
    console.log("2. Defender");
    const opcao = prompt("Digite a opcao: "); // opcao digitada no terminal

    let vidaAtual;
    if (opcao === '1') {
        console.log("digimon atacou");
        vidaAtual = await ataca(instanciaDigimon, monstro, true);
        monstro.vida_atual = vidaAtual.rows[0].vida_atual;
    } else if (opcao === '2') {
        console.log("digimon defendeu");
        vidaAtual = await defende(instanciaDigimon, false);
        instanciaDigimon.vida_atual = vidaAtual.rows[0].vida_atual;
    } else {
        console.log("opcao invalida!");
    }
}

async function batalhaMonstroBate(instanciaDigimon, monstro) {
    const opcao = Math.floor(Math.random() * 2) + 1;

    let vidaAtual;
    if (opcao === 1) {
        console.log("monstro atacou");
        vidaAtual = await ataca(monstro, instanciaDigimon, false);
        instanciaDigimon.vida_atual = vidaAtual.rows[0].vida_atual;
    } else {
        console.log("monstro defendeu");
        vidaAtual = await defende(monstro, true);
        monstro.vida_atual = vidaAtual.rows[0].vida_atual;
    }
}

async function ataca(atacante, defendente, isMonster) {
    try {
        return await db.query(`update ${isMonster ? 'monstro' : 'instancia_digimon'} set vida_atual = vida_atual
         - ${atacante.dano_habilidade} - ${atacante.ataque} where 
         ${isMonster ? 'id_monstro' : 'id_instancia_digimon'} = '${isMonster ? defendente.id_monstro : defendente.id_instancia_digimon}' returning vida_atual`);
    } catch (error) {
        console.log(error.stack);
        console.log("falha ao atacar");
    }
}

async function defende(atacante, isMonster) {
    try {
        return await db.query(`update ${isMonster ? 'monstro' : 'instancia_digimon'} set vida_atual = vida_atual
         + ${atacante.defesa_habilidade} + ${atacante.defesa} where 
         ${isMonster ? 'id_monstro' : 'id_instancia_digimon'} = '${isMonster ? atacante.id_monstro : atacante.id_instancia_digimon}' returning vida_atual`);
    } catch (error) {
        console.log(error.stack);
        console.log("falha ao defender");
    }
}
module.exports = { criaBatalha };