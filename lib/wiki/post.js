(function() {
  var base, core, post, site;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  core = std('import core');
  site = std('import site');
  base = core.mixin(site.post);
  post = (function() {
    function post() {}
    __extends(post, base);
    return post;
  })();
  exports.post = post;
}).call(this);
