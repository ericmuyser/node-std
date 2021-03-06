(function() {
  var base, core, debug, game, gfx, math, player;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  core = std('import core');
  game = std('import game');
  math = std('import math');
  debug = std('import debug');
  gfx = std('import gfx');
  base = core.mixin(game.npc);
  player = (function() {
    function player() {
      debug.write('[game.player] Initializing player.', this, {
        level: 9
      });
      this.set_position(this.position);
    }
    __extends(player, base);
    player.prototype.deconstructor = function() {
      return this.model.remove();
    };
    player.prototype.move = function(direction) {
      if (!this.control) {
        return;
      }
      if (direction.x === 0 && direction.y === 0) {
        return;
      }
      this.position.x += direction.x;
      this.position.y += direction.y;
      return this.set_position(this.position);
    };
    player.prototype.set_position = function(position) {
      this.position = position;
      this.emit('set_position');
      if (this.control) {
        this.stream.send({
          command: 'update<player:position>',
          position: this.position
        });
        return;
      }
      return debug.write('[game.player] Updating player position.', this.position, {
        level: 9
      });
    };
    player.prototype.draw = function(camera) {
      return this.model.css({
        left: ((this.position.x - camera.position.x) * this.speed) + camera.viewport.width / 2,
        top: (((this.position.y * -1) + camera.position.y) * this.speed) + camera.viewport.height / 2
      });
    };
    player.prototype.model = null;
    player.prototype.control = false;
    player.prototype.position = new math.vector;
    player.prototype.speed = 50;
    player.prototype.stream = null;
    player.prototype.camera = new gfx.camera;
    player.prototype.id = null;
    return player;
  })();
  exports.player = player;
}).call(this);
