var prompt = require("prompt-sync")();
const db = require("./db");

const digimon = require("./digimon");
const digivice = require("./digivice");

async function selecionarJogador() {
    console.clear();

    const nomeJogador = prompt("Digite o nome do seu jogador: ");

    const jogadorEncontrado = await getJogador(nomeJogador);
    console.log(jogadorEncontrado)
    if (jogadorEncontrado !== undefined) {
        console.clear();
        console.log(`Bem vindo de volta ${nomeJogador}!!\n`);
        return jogadorEncontrado;
    }

    const jogadorCriado = await criarJogador(nomeJogador);

    return jogadorCriado;
}

async function criarJogador(nomeJogador) {
    try {
        console.clear();
        console.log("Olá " + nomeJogador + ", escolha a categoria do seu jogador: \n");

        const resCategoriaJogador = await db.query(`SELECT * FROM categoria_jogador`);
        let auxCategoria = 1;
        resCategoriaJogador.rows.map((result) => {
            console.log(
                auxCategoria++ + ". " + result.tipo + ". História: " + result.historia
            );
        });

        console.log("\n")
        const categoriaJogador = Number(
            prompt("Digite a categoria do seu jogador: ")
        );

        const id_categoria_jogador = resCategoriaJogador.rows[categoriaJogador - 1].id_categoria_jogador;

        const jogadorCriado = await db.query(
            `INSERT INTO jogador(nome, id_categoria_jogador) 
            VALUES('${nomeJogador}', '${id_categoria_jogador}') RETURNING *`
        )
        console.clear();
        console.log("jogador e digivice criado com sucesso");

        // seleciona a digivice criada
        const resDigivice = await digivice.getDigivice(jogadorCriado.rows[0]);

        //da 2 instancias de digimons para o jogador e alguns itens
        console.log("Agora você vai ganhar 2 digimons para explora o mundo e voltar pra casa!!")
        await digimon.atribuiDigimons(resDigivice)

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
        console.log({nomeJogador, jogadorCriado})
        return jogadorCriado.rows[0];

    } catch {
        console.log("jogador nao encontrado!");
        return null;
    }
}

async function movimentaJogador(resRegiao, jogadorCriado) {
    let posicao_x = resRegiao.eixo_x;
    let posicao_y = resRegiao.eixo_y;

    //sabendo para quais lados o jogador pode ir, fazer uma query de select no banco para trazer as regioes as quais ele pode ir
    //aumentando ou diminuindo em 1 o eixo_x ou eixo_uy
    let regiaoDestino;
    let idRegiao = [0, 0, 0, 0];

    console.log(`A partir da regiao ${resRegiao.nome} voce pode ir para esses lugares: \n`);
    
    if (esquerda(posicao_x)) {
        regiaoDestino = await db.query(
            `SELECT * FROM public.regiao WHERE (eixo_x = ${posicao_x - 1
            })  AND (eixo_y = ${posicao_y})`
        );
        console.log("1. " + regiaoDestino.rows[0].nome);
        idRegiao[0] = regiaoDestino.rows[0].id_regiao;
    }
    if (direita(posicao_x)) {
        regiaoDestino = await db.query(
            `SELECT * FROM public.regiao WHERE (eixo_x = ${posicao_x + 1
            })  AND (eixo_y = ${posicao_y})`
        );
        console.log("2. " + regiaoDestino.rows[0].nome);
        idRegiao[1] = regiaoDestino.rows[0].id_regiao;
    }
    if (cima(posicao_y)) {
        regiaoDestino = await db.query(
            `SELECT * FROM public.regiao WHERE (eixo_x = ${posicao_x})  AND (eixo_y = ${posicao_y + 1
            })`
        );        
        console.log("3. " + regiaoDestino.rows[0].nome);
        idRegiao[2] = regiaoDestino.rows[0].id_regiao;
    }
    if (baixo(posicao_y)) {
        regiaoDestino = await db.query(
            `SELECT * FROM public.regiao WHERE (eixo_x = ${posicao_x})  AND (eixo_y = ${posicao_y - 1
            })`
        );
        console.log("4. " + regiaoDestino.rows[0].nome);
        idRegiao[3] = regiaoDestino.rows[0].id_regiao;
    }
    console.log('\n')
    regiaoDestino = Number(prompt("Escolha o numero da sua regiao destino: "));

    const jogadorAtualizado = await atualizaReagioJogador(idRegiao[regiaoDestino - 1], jogadorCriado);
    console.clear();
    return jogadorAtualizado;
}

async function atualizaReagioJogador(idRegiao, jogadorCriado) {
    try {
        const jogadorAtualizado = await db.query(`UPDATE jogador SET id_regiao = '${idRegiao}' WHERE id_jogador = '${jogadorCriado.id_jogador}' RETURNING *`);
        return jogadorAtualizado.rows[0];
    } catch (error) {
        console.error(error)
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

module.exports = { selecionarJogador, movimentaJogador };
