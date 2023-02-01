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
            console.log("Digimon escolhido:", digimon.nome);
            await db.query(`INSERT INTO public.instancia_digimon (nivel, id_digimon, id_digivice) VALUES(5, '${digimon.id_digimon}', '${digivice.id_digivice}');`)
        }

        console.log("Digimons escolhidos com sucesso!")

    } catch (error) {
        console.log(error.message);
        return null;
    }
}

module.exports = { atribuiDigimons }