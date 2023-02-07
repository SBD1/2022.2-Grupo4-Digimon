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

function direita(posicao_x) {
    if (posicao_x >= 0 && posicao_x <= 2) {
        return true;
    }
    return false;
}
function esquerda(posicao_x) {
    if (posicao_x >= 1 && posicao_x <= 3) {
        return true;
    }
    return false;
}
function cima(posicao_y) {
    if (posicao_y >= 0 && posicao_y <= 1) {
        return true;
    }
    return false;
}
function baixo(posicao_y) {
    if (posicao_y >= 1 && posicao_y <= 2) {
        return true;
    }
    return false;
}

module.exports = { getRegiao , direita, esquerda, cima, baixo}