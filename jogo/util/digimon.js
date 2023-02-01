const db = require("./db");

async function getRandomDigimons() {
    try {
        const getDigimons = await db.query(`SELECT * FROM digimon d  ORDER BY RANDOM() LIMIT 2`);

        return getDigimons.rows;
    } catch (error) {
        console.log(error)
        return null;
    }
}

async function atribuiDigimons(digivice) {
    try {

        const getDigimons = await getRandomDigimons();
        // console.log(getDigimons);

        for (const digimon of getDigimons) {
            console.log(digimon);
            await db.query(
            `INSERT INTO public.instancia_digimon
            (vida_atual, vida, defesa, ataque, velocidade, id_digimon, id_digivice)
            VALUES(${digimon.vida_por_nivel}, ${digimon.vida_por_nivel}, ${digimon.defesa_por_nivel}, 
            ${digimon.ataque_por_nivel}, ${digimon.velocidade_por_nivel}, '${digimon.id_digimon}', '${digivice.id_digivice}');
            `)
        }

    } catch (error) {
        console.log(error.message);
        return null;
    }
}

module.exports = { atribuiDigimons }