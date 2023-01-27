var prompt = require("prompt-sync")();
const db = require("./db");

async function selecionarJogador() {
    console.clear();

    const nomeJogador = prompt("Digite o nome do seu jogador: ");

    const jogadorEncontrado = await getJogador(nomeJogador);
    if (jogadorEncontrado !== undefined) {
        console.log(`BEM VINDO DE VOLTA ${nomeJogador}`);
        return jogadorEncontrado;
    }

    const jogadorCriado = await criarJogador(nomeJogador);

    return jogadorCriado;
}

async function criarJogador(nomeJogador) {
    try {
        console.log(nomeJogador + ", escolha a categoria do seu jogador: ");

        const resCategoriaJogador = await db.query(`SELECT * FROM categoria_jogador`);
        let auxCategoria = 1;
        resCategoriaJogador.rows.map((result) => {
            console.log(
                auxCategoria++ + ". " + result.tipo + ". Historia: " + result.historia
            );
        });

        const categoriaJogador = Number(
            prompt("Digite a categoria do seu jogador: ")
        );

        const id_categoria_jogador = resCategoriaJogador.rows[categoriaJogador - 1].id_categoria_jogador;

        const jogadorCriado = await db.query(
            `INSERT INTO jogador(nome, id_categoria_jogador,id_regiao) 
            VALUES('${nomeJogador}', '${id_categoria_jogador}', '738ccbc9-9f13-4f71-90c5-10383ff4e9dc') RETURNING *`
        )
        console.log("jogador criado com sucesso");
        return jogadorCriado.rows[0];

    } catch (err) {
        console.error(err);
        console.log("erro ao criar jogador!");
        return null;
    }
}

async function getJogador(nomeJogador) {
    try {
        const jogadorCriado = await db.query(`SELECT * FROM jogador WHERE nome = '${nomeJogador}'`);

        return jogadorCriado.rows[0];

    } catch {
        console.log("jogador nao encontrado!");
        return null;
    }
}

async function getRegiao(jogadorCriado) {
    const resRegiao = await db.query(
        `SELECT * FROM regiao where id_regiao = '${jogadorCriado.id_regiao}'`
    );
    //posicções que o jogador se encontra

    console.log(`${jogadorCriado.nome} esta na regiao ${resRegiao.rows[0].nome}`);
    return resRegiao;
}

async function movimentaJogador(resRegiao, jogadorCriado) {
    let posicao_x = resRegiao.rows[0].eixo_x;
    let posicao_y = resRegiao.rows[0].eixo_y;

    //sabendo para quais lados o jogador pode ir, fazer uma query de select no banco para trazer as regioes as quais ele pode ir
    //aumentando ou diminuindo em 1 o eixo_x ou eixo_uy
    let regiaoDestino;
    let idRegiao = [0, 0, 0, 0];
    console.log("A partir dessa regiao voce pode ir para esses lugares: \n");
    if (esquerda(posicao_x)) {
        regiaoDestino = await db.query(
            `SELECT * FROM public.regiao WHERE (eixo_x = ${posicao_x - 1
            })  AND (eixo_y = ${posicao_y})`
        );
        console.log("1)" + regiaoDestino.rows[0].nome);
        idRegiao[0] = regiaoDestino.rows[0].id_regiao;
    }
    if (direita(posicao_x)) {
        regiaoDestino = await db.query(
            `SELECT * FROM public.regiao WHERE (eixo_x = ${posicao_x + 1
            })  AND (eixo_y = ${posicao_y})`
        );
        console.log("2)" + regiaoDestino.rows[0].nome);
        idRegiao[1] = regiaoDestino.rows[0].id_regiao;
    }
    if (cima(posicao_y)) {
        regiaoDestino = await db.query(
            `SELECT * FROM public.regiao WHERE (eixo_x = ${posicao_x})  AND (eixo_y = ${posicao_y + 1
            })`
        );
        console.log("3)" + regiaoDestino.rows[0].nome);
        idRegiao[2] = regiaoDestino.rows[0].id_regiao;
    }
    if (baixo(posicao_y)) {
        regiaoDestino = await db.query(
            `SELECT * FROM public.regiao WHERE (eixo_x = ${posicao_x})  AND (eixo_y = ${posicao_y - 1
            })`
        );
        console.log("4)" + regiaoDestino.rows[0].nome);
        idRegiao[3] = regiaoDestino.rows[0].id_regiao;
    }
    regiaoDestino = Number(prompt("Escolha o numero da sua regiao destino: "));

    console.log(idRegiao[regiaoDestino - 1]);
    const jogadorAtualizado = await atualizaReagioJogador(idRegiao[regiaoDestino - 1], jogadorCriado);
    console.clear();
    // getRegiao(jogadorAtualizado.rows[0]);
    return jogadorAtualizado.rows[0];
}

async function atualizaReagioJogador(idRegiao, jogadorCriado) {
    return await db.query(`UPDATE jogador SET id_regiao = '${idRegiao}' WHERE id_jogador = '${jogadorCriado.id_jogador}' RETURNING *`);
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

module.exports = { selecionarJogador, movimentaJogador, getRegiao };
