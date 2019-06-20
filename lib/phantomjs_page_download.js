var system = require('system');
var page   = require('webpage').create();
var url    = system.args[1];

page.open(url, function () {
  // Output content to stdout
  console.log(page.content);

  phantom.exit();
});
