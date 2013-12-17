
/**
 * Module dependencies.
 */

require('coffee-script')

var express = require('express')
  , http = require('http')
  , path = require('path');

var app = express();

var dirname = '.';

// logic to override defaults such as 'dirname' which is the folder that server uses as the root of the website
process.argv.forEach(function (val, index, array) {
  console.log(index + ': ' + val);
  if (index === 2) {
    console.log('Overriding the server\'s default home folder \'' + dirname + '\' with \'' + val + '\' folder...\n');
    dirname = val;
  }
});

app.configure(function(){
  app.set('port', process.env.PORT || 3000);
//  app.set('views', __dirname + '/views');
//  app.set('view engine', 'jade');
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser('your secret here'));
  app.use(express.session());
  app.use(app.router);
  app.use(express.static(path.join(__dirname, dirname)));
});

app.configure('development', function(){
  app.use(express.errorHandler());
});

Ping = require('./ping');
var ping = new Ping();

if (app.settings.env == "production") {
 /* At the top, with other redirect methods before other routes */
  app.all('*',function(req,res,next) {
    // console.log("REQUEST",req.originalUrl)
    
    // console.log('https://'+req.host+req.originalUrl)
    
    if(req.headers['x-forwarded-proto']!='https') {
      console.log("Redirecting",'https://'+req.host+app.get(port)+req.originalUrl);
      res.redirect('https://'+req.host+app.get(port)+req.originalUrl);
    }
    else
      next() /* Continue to other routes if we're not redirecting */
    });
}

http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
  console.log("ENVIRONMENT",app.settings.env);
  ping.do();
  if (app.settings.env == "production") {
  }
})
