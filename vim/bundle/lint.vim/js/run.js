var args = arguments;

(function() {

  // first argument is the linter type (jshint, csslint)
  var linter = args[0];

  // followed by the list of files to check
  var files = args.slice(1);

  if(files.length === 0 && output === 'console') {
    print('No input files');
    quit(0);
  }

  // formats the error as a compact gcc style message
  var formatGcc = function(error) {
    var message = (error.evidience ? error.evidence.replace(/^\s+|\s+$/g, '') + '\n' : '') + error.reason;
    return '(' + error.line + '): JSHint warning: ' + message;
  };

  // result object of the form: filename -> [error, error, ...]
  var result = {};
  for(var i=0; i<files.length; i++) {
    var file = files[i];
    if(!file) continue;

    var input = read(file);
    if(!input) continue;

    var errors = [];
    if(linter === 'jshint') {
      if(!JSHINT(input, JSHINT_OPTIONS, JSHINT_GLOBALS)) {
        JSHINT.errors.forEach(function (error) {
          if(!!error) errors.push(error);
        });
      }
      result[file] = errors;
    }

    else if(linter === 'csslint') {
      var report = CSSLint.verify(input, CSS_LINT_OPTIONS);
      if(report.messages.length > 0) {
        for(var j=0; j<report.messages.length; j++) {
          errors.push(report.messages[j]);
        }
      }
      result[file] = errors;
    }
  }

  for(var filename in result) {
    if(result.hasOwnProperty(filename)) {
      var errors = result[filename];
      for(var i=0; i<result[filename].length; i++) {
        var error = errors[i];
        var message = filename + 
          '(' + error.line + '): ' + linter + ' warning: ' + 
          (error.evidience ? error.evidence.replace(/^\s+|\s+$/g, '') + '\n' : '') + (error.reason || error.message);
        print(message);
      }
    }
  }

  return 0;
})();

quit(0); 
