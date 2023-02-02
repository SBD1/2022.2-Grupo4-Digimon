const db = require("./db");

async function criaBatalha(instanciaDigimon) {
    try {
        await db.query(`call cria_batalha('${instanciaDigimon.id_instancia_digimon}')`);
        
        const resMonstros = await db.query(`select * from batalha join monstro on batalha.id_batalha = monstro.id_batalha where batalha.id_instancia_digimon = '${instanciaDigimon.id_instancia_digimon}'`);
        
        console.log("logicia dos danos e tal");
        
        await db.query(`delete from batalha where id_batalha = '${resMonstros.rows[0].id_batalha}'`); // deleta batalha
    } catch (error) {
        console.log(error.stack);
        console.log("falha ao criar batalha");
    }

}

module.exports = { criaBatalha };