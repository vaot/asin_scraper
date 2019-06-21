var system = require('system');
var page   = require('webpage').create();
var url    = system.args[1];

page.settings.userAgent = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.71 Safari/537.36';

page.open(url, function () {
  // Output content to stdout
  console.log(page.content);

  phantom.exit();
});
