
const Handlebars = require("handlebars");
const Data       = process.argv[2];
const Template   = process.argv[3];
const FS         = require("fs");
const PATH       = require("path");

const source = FS.readFileSync(Template).toString();
const template = Handlebars.compile(source, {strict: true});

var data = JSON.parse(FS.readFileSync(Data).toString());

var current = source;
var old     = "";
while (current !== old) {
  old = current;
  current = Handlebars.compile(current, {strict: true})(data);
}
console.log(current);


