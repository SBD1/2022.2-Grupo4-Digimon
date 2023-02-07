const db = require("./db");

async function acessaDigivice(jogadorAtualizado){
    try {
        //acessa a id_digivice para acessar as instancias de digimon e item para cada jogador
        const resDigivice = await getDigivice(jogadorAtualizado);
        const listDigimom = await getInstanciaDigimon(resDigivice);
        const resInstItem = await getInstanciaItem(resDigivice);

        //console.log(resDigivice);
        console.clear();
        console.log("\nDigivice\n\n")
        
        console.log("Lista de Digimons")

        if (listDigimom.length > 0) {
            listDigimom.map((result) => {
                console.log("\n\t" + result.nome);
                console.log("\n\tTipo: " + result.tipo);
                console.log("\tNivel: " + result.nivel);
                console.log("\tVida (total): " + result.vida + ` (${result.vida})`);
                console.log("\tAtaque: " + result.ataque);
                console.log("\tDefesa: " + result.defesa);
                console.log("\tValocidade: " + result.velocidade);
                console.log("\tDano Habilidade: " + result.dano_habilidade);
                console.log("\tDefesa Habilidade: " + result.defesa_habilidade);
            });
        } else {
            console.log("\n\t Sem Digimons cadastrados.\n")
        }

        console.log("\n\nLista de Itens")

        if (resInstItem.length > 0) {

        } else {
            console.log("\n\t Sem Itens cadastrados.\n")
        }
    } catch (err) {
        console.error(err);
        console.log("erro ao acessar digivice")
    }
}

async function getDigivice(jogadorAtualizado){
    try {
        const resDigivice = await db.query(`select id_digivice from digivice where id_jogador = '${jogadorAtualizado.id_jogador}'`);

        return resDigivice.rows[0];

    } catch (err) {
        console.error(err);
        console.log("erro ao acessar digivice")
    }
}

async function getInstanciaDigimon(digivice){
    try {
        const resInstDigimon = await db.query(`select * from view_instancia_digimon where id_digivice = '${digivice.id_digivice}'`);

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