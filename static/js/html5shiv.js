// I hate inlining JS, but crazy browsers lead to crazy solutions
// (thanks IE)

// Load all new HTML5 elements and create them so that during html
// parsing, IE will at least recognize that the new elements exist.

var e = ("abbr,article,aside,audio,canvas,datalist,details," +
	"figure,footer,header,hgroup,main,mark,menu,meter,nav,output," +
	"progress,section,time,video").split(',');
for (var i = 0; i < e.length; i++) {
	document.createElement(e[i]);
}