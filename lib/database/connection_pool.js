(function() {
  var base, connection_pool, core;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  core = std('import core');
  base = core.mixin(core.base);
  connection_pool = (function() {
    function connection_pool() {}
    __extends(connection_pool, base);
    connection_pool.prototype.connections = core.collection;
    return connection_pool;
  })();
  exports.connection_pool = connection_pool;
}).call(this);
