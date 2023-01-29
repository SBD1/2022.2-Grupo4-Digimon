const db = require("./db");

async function getRegiao(jogadorCriado) {
    try {
        const resRegiao = await db.query(
            `SELECT * FROM regiao where id_regiao = '${jogadorCriado.id_regiao}'`
        );
        return resRegiao.rows[0];
    } catch (error) {
        console.error(error);
        return null;
    }
}

module.exports = { getRegiao }