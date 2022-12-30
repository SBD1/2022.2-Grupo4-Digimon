import Phaser from 'phaser';

var attackText;
var moveText;
var upText;
var downText;
var leftText;
var rightText;
var map;

const moveRate = 32;
class MyGame extends Phaser.Scene {

    constructor() {
        super();
    }

    preload() {
        this.load.tilemapTiledJSON("map", "src/assets/map.json");
        this.load.image('tiles', "src/assets/tilemaps/tileset_16x16_final_1.png");
        this.load.image("sprite", "src/assets/agumon.png");
    }

    create() {
        map = this.make.tilemap({ key: "map", tileWidth: 16, tileHeight: 16 });
        const tileset = map.addTilesetImage('tileset_16x16_final_1', 'tiles');
        map.createLayer('Camada1', tileset, 0, 0);
        const start = map.objects[0].objects[0];
        this.face = this.add.sprite(start.x + 10, start.y + 16, "sprite");

        // evento de teclado: this.input.keyboard.addKey(Phaser.Input.Keyboard.KeyCodes.UP);

        this.createMenu();
        this.toggleMoveMenu(false);
    }

    toggleMoveMenu(toggle) {
        upText.setVisible(toggle);
        downText.setVisible(toggle);
        leftText.setVisible(toggle);
        rightText.setVisible(toggle);

        attackText.setVisible(!toggle);
        moveText.setVisible(!toggle);
    }

    createMenu() {
        const menu = map.objects[0].objects[1];
        this.add.text(menu.x, menu.y, 'O que deseja fazer?');
        attackText = this.add.text(menu.x, menu.y + 20, 'Atacar');
        moveText = this.add.text(menu.x + 200, menu.y + 20, 'Mover');

        upText = this.add.text(menu.x, menu.y + 20, 'Cima');
        downText = this.add.text(menu.x + 100, menu.y + 20, 'Baixo');
        leftText = this.add.text(menu.x + 200, menu.y + 20, 'Esquerda');
        rightText = this.add.text(menu.x + 300, menu.y + 20, 'Direita');

        upText.setInteractive();
        upText.on('clicked', () =>  this.moveHandler('up'), this);

        downText.setInteractive();
        downText.on('clicked', () =>  this.moveHandler('down'), this);

        leftText.setInteractive();
        leftText.on('clicked', () =>  this.moveHandler('left'), this);

        rightText.setInteractive();
        rightText.on('clicked',() =>  this.moveHandler('right'), this);

        attackText.setInteractive();
        attackText.on('clicked', this.clickHandler, this);

        moveText.setInteractive();
        moveText.on('clicked', this.clickHandler, this);

        this.input.on('gameobjectup', function (pointer, gameObject) {
            gameObject.emit('clicked', gameObject);
        }, this);
    }

    clickHandler() {
        this.toggleMoveMenu(true);
    }

    moveHandler(direction) {
        if (direction === 'up') {
            this.face.y -= moveRate;
        }

        if (direction === 'left') {
            this.face.x -= moveRate;
        }

        if (direction === 'down') {
            this.face.y += moveRate;
        }

        if (direction === 'right') {
            this.face.x += moveRate;
        }
        this.toggleMoveMenu(false);
    }
}

const config = {
    type: Phaser.AUTO,
    scale: {
        mode: Phaser.Scale.FIT
    },
    parent: 'phaser-example',
    width: 770,
    height: 770,
    scene: MyGame
};

const game = new Phaser.Game(config);
