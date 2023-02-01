const db = require("./db");

async function acessaDigivice(jogadorAtualziado){

    try {
        //acessa a id_digivice para acessar as instancias de digimon e item para cada jogador
        const idDigivice = await (await db.query(`select id_digivice from digivice where id_jogador = '${jogadorAtualziado.id_jogador}'`)).rows[0].id_digivice;
        console.log(idDigivice)
        const listDigimom = await db.query(`select * from instancia_digimon where id_digivice = '${idDigivice}'`)
        const listItem = await db.query(`select * from instancia_item where id_digivice = '${idDigivice}'`)

        console.log(listDigimom)
        console.log(listItem)


    } catch (err) {
        console.error(err);
        console.log("erro ao ceaacessar digivce;")
    }

}

module.exports = { acessaDigivice }