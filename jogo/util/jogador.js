var prompt = require("prompt-sync")();
const db = require('./db');

async function criarJogador() {
    console.clear();

    const resCategoriaJogador = await db.query(`SELECT * FROM categoria_jogador`);
    const nomeJogador = prompt("Digite o nome do seu jogador: ")
    console.clear()

    console.log(nomeJogador + ", escolha a categoria do seu jogador: ");

    let auxCategoria = 1;
    resCategoriaJogador.rows.map((result) => {
        console.log(
            auxCategoria++ + ". " + result.tipo + ". Historia: " + result.historia
        );
    });

    const categoriaJogador = Number(prompt("Digite a categoria do seu jogador: "));

    const id_categoria_jogador = resCategoriaJogador.rows[categoriaJogador - 1].id_categoria_jogador;
    await db.query(`INSERT INTO jogador(nome, id_categoria_jogador,id_regiao) 
    VALUES('${nomeJogador}', '${id_categoria_jogador}', 'c7bedb33-9534-4956-bc4b-cb5f7c2260da')`)
        .then(() => console.log("Jogador Criado com sucesso!"))
        .catch(() => console.log("Erro ao criar jogador!"));

    return nomeJogador;
}

async function getRegiao(nomeJogador) {
    const resJogador = await db.query(`SELECT * FROM jogador WHERE nome = '${nomeJogador}'`);
    // console.log(resJogador);

    const resRegiao = await db.query(`SELECT * FROM regiao where id_regiao = '${resJogador.rows[0].id_regiao}'`);

    console.log(`${nomeJogador} esta na regiao ${resRegiao.rows[0].nome}`);
}

async function validaMovimentos() {

}

async function movimentarJogador(nomeJogador) {
    await getRegiao(nomeJogador)
}

module.exports = { criarJogador, movimentarJogador };