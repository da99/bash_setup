
const ARGS       = process.argv.slice(2);
const Handlebars = require("handlebars");
const Template   = ARGS.pop();
const Data       = ARGS.pop() || "ENV";
const FS         = require("fs");
const PATH       = require("path");

const source   = FS.readFileSync(Template).toString();
const template = Handlebars.compile(source, {strict: true});

var data = (Data === 'ENV') ? process.env : JSON.parse(FS.readFileSync(Data).toString());


var current = source;
var old     = "";
while (current !== old) {
  old = current;
  current = Handlebars.compile(current, {strict: true})(data);
}
console.log(current);


