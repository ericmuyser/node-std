(function() {
  var std;
  std = require('std').std;
  std.add_path('./modules');
  std('import my_module');
}).call(this);
