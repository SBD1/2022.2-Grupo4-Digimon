const db = require("./db");

async function acessaDigivice(jogadorAtualziado){
    try {
        //acessa a id_digivice para acessar as instancias de digimon e item para cada jogador
        const resDigivice = await getDigivice(jogadorAtualziado);
        const listDigimom = await getInstanciaDigimon(resDigivice);
        const resInstItem = await getInstanciaItem(resDigivice);

        console.log(resDigivice);
        console.log(listDigimom);
        console.log(resInstItem);

    } catch (err) {
        console.error(err);
        console.log("erro ao acessar digivice")
    }
}

async function getDigivice(jogadorAtualziado){
    try {
        const resDigivice = await db.query(`select id_digivice from digivice where id_jogador = '${jogadorAtualziado.id_jogador}'`);

        return resDigivice.rows[0];

    } catch (err) {
        console.error(err);
        console.log("erro ao acessar digivice")
    }
}

async function getInstanciaDigimon(digivice){
    try {
        const resInstDigimon = await db.query(`select * from instancia_digimon where id_digivice = '${digivice.id_digivice}'`);

        return resInstDigimon.rows;

    } catch (err) {
        console.error(err);
        console.log("erro ao acessar instancia digimon")
    }
}

async function getInstanciaItem(digivice){
    try {
        const resInstItem = await db.query(`select * from instancia_item where id_digivice = '${digivice.id_digivice}'`);

        return resInstItem.rows;

    } catch (err) {
        console.error(err);
        console.log("erro ao acessar instancia item")
    }
}


module.exports = { acessaDigivice, getInstanciaDigimon, getDigivice }