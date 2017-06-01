/* Generate Rabbit with PixiJS */
var app = new PIXI.Application(window.innerWidth, window.innerHeight, { backgroundColor: 0x000000 });
document.body.appendChild(app.view);

// Scale mode for all textures, will retain pixelation
PIXI.settings.SCALE_MODE = PIXI.SCALE_MODES.NEAREST;

var sprite = PIXI.Sprite.fromImage('<%= asset_path('rabbit-sm.png') %>');

// Set the initial position
sprite.anchor.set(0.5);
sprite.x = app.renderer.width / 2;
sprite.y = app.renderer.height / 2;

// Opt-in to interactivity
sprite.interactive = true;

// Shows hand cursor
sprite.buttonMode = true;

// Pointers normalize touch and mouse
sprite.on('pointerdown', onClick);

// Alternatively, use the mouse & touch events:
// sprite.on('click', onClick); // mouse-only
// sprite.on('tap', onClick); // touch-only

app.stage.addChild(sprite);

function onClick () {
  sprite.scale.x *= 1.25;
  sprite.scale.y *= 1.25;
}

$(document).ready(function() {
  $('#entry-btn').animate({ bottom: '25%' }, function() {
    $(this).addClass('animated rubberBand');
  });
});