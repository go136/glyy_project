/**
 * 使用underscore.template扩展jquery
 * @author nekolr
 */
;(function ($) {
    var escapes = {
        "'":      "'",
        '\\':     '\\',
        '\r':     'r',
        '\n':     'n',
        '\u2028': 'u2028',
        '\u2029': 'u2029'
    }, escapeMap = {
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        '"': '&quot;',
        "'": '&#x27;',
        '`': '&#x60;'
    };
    var escapeChar = function(match) {
        return '\\' + escapes[match];
    };
    var createEscaper = function(map) {
        var escaper = function(match) {
            return map[match];
        };
        var source = "(?:&|<|>|\"|'|`)";
        var testRegexp = new RegExp(source);
        var replaceRegexp = new RegExp(source, 'g');
        return function(string) {
            string = string === null ? '' : '' + string;
            return testRegexp.test(string) ? string.replace(replaceRegexp, escaper) : string;
        };
    };
    var escape = createEscaper(escapeMap);
    $.extend({
        templateSettings: {
            escape: /{{-([\s\S]+?)}}/g,
            interpolate : /{{=([\s\S]+?)}}/g,
            evaluate: /{{([\s\S]+?)}}/g
        },
        escapeHtml: escape,
        template: function (text, settings) {
            var options = $.extend(true, {}, this.templateSettings, settings);
            var matcher = new RegExp([options.escape.source, options.interpolate.source, options.evaluate.source].join('|') + '|$', 'g');
            var index = 0;
            var source = "__p+='";
            text.replace(matcher, function(match, escape, interpolate, evaluate, offset) {
                source += text.slice(index, offset).replace(/[\\'\r\n\u2028\u2029]/g, escapeChar);
                index = offset + match.length;
                if (escape) {
                    source += "'+\n((__t=(" + escape + "))==null?'':$.escapeHtml(__t))+\n'";
                } else if (interpolate) {
                    source += "'+\n((__t=(" + interpolate + "))==null?'':__t)+\n'";
                } else if (evaluate) {
                    source += "';\n" + evaluate + "\n__p+='";
                }
                return match;
            });
            source += "';\n";
            if (!options.variable) source = 'with(obj||{}){\n' + source + '}\n';
            source = "var __t,__p='',__j=Array.prototype.join," +
                "print=function(){__p+=__j.call(arguments,'');};\n" +
                source + 'return __p;\n';
            try {
                var render = new Function(options.variable || 'obj', source);
            } catch (e) {
                e.source = source;
                throw e;
            }
            var template = function(data) {
                return render.call(this, data);
            };
            var argument = options.variable || 'obj';
            template.source = 'function(' + argument + '){\n' + source + '}';
            return template;
        }
    });
})(jQuery);