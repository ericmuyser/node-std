(function() {
  exports.device = std_import('input.device').device;
  exports.keyboard = std_import('input.keyboard');
  exports.key = exports.keyboard.code;
  exports.mouse = std_import('input.mouse');
  exports.touch = std_import('input.touch');
  std_import('input.vendor.jquery-jswipe');
  std_import('input.vendor.jquery-mousewheel');
}).call(this);
