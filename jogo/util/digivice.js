const db = require("./db");

async function criaDigivice(idJogador) {
    try {
        const digivice = await db.query(`INSERT INTO digivice (id_jogador) VALUES('${idJogador}') RETURNING *`);
        console.log("DIGIVICE ATRIBUIDA COM SUCESSO")
        return digivice.rows[0];

    } catch (err) {
        console.error(err);
        console.log("sua digivice nao foi atribuida a voce :(");
    }
}

module.exports = { criaDigivice }