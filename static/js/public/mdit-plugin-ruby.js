/**
 * Bundled by jsDelivr using Rollup v2.79.2 and Terser v5.37.0.
 * Original file: /npm/@mdit/plugin-ruby@0.16.0/lib/index.js
 *
 * Do NOT use SRI with dynamically generated files! More information: https://www.jsdelivr.com/using-sri-with-dynamic-files
 */
const s=(s,r)=>{let e;const p=s.pos,o=s.posMax;if(r||"{"!==s.src.charAt(p)||p+4>=o)return!1;s.pos=p+1;let t=0,n=0;for(;s.pos<o;){if(t){if("}"===s.src.charAt(s.pos)&&"\\"!==s.src.charAt(s.pos-1)){n=s.pos;break}}else":"===s.src.charAt(s.pos)&&"\\"!==s.src.charAt(s.pos-1)&&(t=s.pos);s.pos++}if(!n||p+1===s.pos)return s.pos=p,!1;s.posMax=s.pos,s.pos=p+1;s.push("ruby_open","ruby",1).markup="{";const u=s.src.slice(p+1,t),c=s.src.slice(t+1,n),l=u.split(""),a=c.split("|");l.length===a.length?l.forEach(((r,p)=>{s.md.inline.parse(r,s.md,s.env,e=[]),s.tokens.push(...e),s.push("rt_open","rt",1),s.md.inline.parse(a[p],s.md,s.env,e=[]),s.tokens.push(...e),s.push("rt_close","rt",-1)})):(s.md.inline.parse(u,s.md,s.env,e=[]),s.tokens.push(...e),s.push("rt_open","rt",1),s.md.inline.parse(c,s.md,s.env,e=[]),s.tokens.push(...e),s.push("rt_close","rt",-1));return s.push("ruby_close","ruby",-1).markup="}",s.pos=s.posMax+1,s.posMax=o,!0},r=r=>{r.inline.ruler.before("text","ruby",s)};export{r as ruby};export default null;
//# sourceMappingURL=/sm/df70b9892ac48f731aeb3845d9d007da9ac4a0317801023494633f5fba6f79c0.map