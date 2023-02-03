const db = require("./db");

async function getDigimon(digimon) {
    try {
        const getDigimons = await db.query(`SELECT * FROM digimon where id_digimon = '${digimon.id_digimon}'`);

        return getDigimons.rows[0];
    } catch (error) {
        console.log(error)
        return null;
    }
}

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

async function curaDigimon(digivice, digimon) {
    try {

        await db.query(`UPDATE public.instancia_digimon
        SET vida_atual = 100 WHERE id_digivice = '${digivice.id_digivice}' AND id_digimon = '${digimon.id_digimon}';`)

        console.log("Digimon curado com sucesso!");
        
    } catch (error) {
        console.log(error.message);
        console.log("Erro ao curar Digimon!");
    }
}

module.exports = { atribuiDigimons, getDigimon, curaDigimon }