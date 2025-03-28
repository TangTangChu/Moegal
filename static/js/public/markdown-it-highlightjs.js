/**
 * Bundled by jsDelivr using Rollup v2.79.1 and Terser v5.19.2.
 * Original file: /npm/markdown-it-highlightjs@4.2.0/index.js
 *
 * Do NOT use SRI with dynamically generated files! More information: https://www.jsdelivr.com/using-sri-with-dynamic-files
 */
import e from "/static/js/public/highlight.js";
var t = Object.defineProperty,
	r = Object.defineProperties,
	n = Object.getOwnPropertyDescriptor,
	l = Object.getOwnPropertyDescriptors,
	o = Object.getOwnPropertyNames,
	i = Object.getOwnPropertySymbols,
	a = Object.prototype.hasOwnProperty,
	c = Object.prototype.propertyIsEnumerable,
	u = (e, r, n) => r in e ? t(e, r, {
		enumerable: !0,
		configurable: !0,
		writable: !0,
		value: n
	}) : e[r] = n,
	s = (e, t) => {
		for (var r in t || (t = {})) a.call(t, r) && u(e, r, t[r]);
		if (i)
			for (var r of i(t)) c.call(t, r) && u(e, r, t[r]);
		return e
	},
	f = (e, t) => r(e, l(t)),
	g = {};
((e, r) => {
	for (var n in r) t(e, n, {
		get: r[n],
		enumerable: !0
	})
})(g, {
	default: () => m
});
var h, p = (h = g, ((e, r, l, i) => {
	if (r && "object" == typeof r || "function" == typeof r)
		for (let c of o(r)) a.call(e, c) || c === l || t(e, c, {
			get: () => r[c],
			enumerable: !(i = n(r, c)) || i.enumerable
		});
	return e
})(t({}, "__esModule", {
	value: !0
}), h));

function d(e, t, r, n, l) {
	try {
		return t.highlight(n, {
			language: "" !== l ? l : "plaintext",
			ignoreIllegals: r
		}).value
	} catch (t) {
		return e.utils.escapeHtml(n)
	}
}

function b(e, t, r, n, l) {
	if ("" !== l) return d(e, t, r, n, l);
	try {
		return t.highlightAuto(n).value
	} catch (t) {
		return e.utils.escapeHtml(n)
	}
}

function j(e) {
	return function(...t) {
		return e(...t).replace(/<code class="/g, '<code class="hljs ').replace(/<code>/g, '<code class="hljs">')
	}
}

function y(e) {
	var t, r;
	for (const n of e.tokens)
		if ("inline" === n.type && null != n.children)
			for (const [l, o] of n.children.entries()) {
				if ("code_inline" !== o.type) continue;
				const i = n.children[l + 1];
				if (null == i) continue;
				const a = /^{:?\.([^}]+)}/.exec(i.content);
				if (null == a) continue;
				const c = a[1];
				i.content = i.content.slice(a[0].length);
				let u = null != (t = o.attrGet("class")) ? t : "";
				u += `${null!=(r=e.md.options.langPrefix)?r:"language-"}${c}`, o.attrSet("class", u), o.meta = f(s({}, o.meta), {
					highlightLanguage: c
				})
			}
}

function O(e, t, r, n, l) {
	var o, i;
	const a = e[t];
	if (null == r.highlight) throw new Error("`options.highlight` was null, this is not supposed to happen");
	const c = r.highlight(a.content, null != (i = null == (o = a.meta) ? void 0 : o.highlightLanguage) ? i : "", "");
	return `<code${l.renderAttrs(a)}>${c}</code>`
}

function m(e, t) {
	const r = s(s({}, m.defaults), t);
	if (null == r.hljs) throw new Error("Please pass a highlight.js instance for the required `hljs` option.");
	null != r.register && function(e, t) {
		for (const [r, n] of Object.entries(t)) e.registerLanguage(r, n)
	}(r.hljs, r.register), e.options.highlight = (r.auto ? b : d).bind(null, e, r.hljs, r.ignoreIllegals), null != e.renderer.rules.fence && (e.renderer.rules.fence = j(e.renderer.rules.fence)), r.code && null != e.renderer.rules.code_block && (e.renderer.rules.code_block = j(e.renderer.rules.code_block)), r.inline && (e.core.ruler.before("linkify", "inline_code_language", y), e.renderer.rules.code_inline = j(O))
}
m.defaults = {
	auto: !1,
	code: !1,
	inline: !1,
	ignoreIllegals: !1
};
var v = Object.create,
	w = Object.defineProperty,
	P = Object.getOwnPropertyDescriptor,
	_ = Object.getOwnPropertyNames,
	I = Object.getOwnPropertySymbols,
	k = Object.getPrototypeOf,
	x = Object.prototype.hasOwnProperty,
	E = Object.prototype.propertyIsEnumerable,
	$ = (e, t, r) => t in e ? w(e, t, {
		enumerable: !0,
		configurable: !0,
		writable: !0,
		value: r
	}) : e[t] = r,
	D = (e, t) => {
		for (var r in t || (t = {})) x.call(t, r) && $(e, r, t[r]);
		if (I)
			for (var r of I(t)) E.call(t, r) && $(e, r, t[r]);
		return e
	},
	L = (e, t, r, n) => {
		if (t && "object" == typeof t || "function" == typeof t)
			for (let l of _(t)) x.call(e, l) || l === r || w(e, l, {
				get: () => t[l],
				enumerable: !(n = P(t, l)) || n.enumerable
			});
		return e
	},
	M = (e, t, r) => (r = null != e ? v(k(e)) : {}, L(!t && e && e.__esModule ? r : w(r, "default", {
		value: e,
		enumerable: !0
	}), e)),
	S = {};
((e, t) => {
	for (var r in t) w(e, r, {
		get: t[r],
		enumerable: !0
	})
})(S, {
	default: () => q
});
var A = (e => L(w({}, "__esModule", {
		value: !0
	}), e))(S),
	H = M(e),
	N = M(p);

function q(e, t) {
	return null == (t = D(D({}, q.defaults), t)).hljs && (t.hljs = H.default), (0, N.default)(e, t)
}
q.defaults = {
	auto: !0,
	code: !0,
	inline: !1,
	ignoreIllegals: !0
};
var G = A.default;
export {
	G as
	default
};
//# sourceMappingURL=/sm/9fbc9c94dcd0ca591daaa2231f4d15f1c9d704cfa47e3611ebd2115f32fa3abb.map