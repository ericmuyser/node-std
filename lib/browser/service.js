(function() {
  var core, service;
  core = std('import core');
  service = (function() {
    function service() {}
    return service;
  })();
  service.prototype = core.mixin(service.prototype, core.base.prototype);
  exports.service = service;
}).call(this);
