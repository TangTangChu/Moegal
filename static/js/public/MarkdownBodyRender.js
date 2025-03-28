import {
    ruby
} from '/static/js/public/mdit-plugin-ruby.js';
import {
    footnote
} from '/static/js/public/mdit-plugin-footnote.js';
import {
    full as emoji
} from '/static/js/public/markdown-it-emoji.js';
import tasklistplg from '/static/js/public/markdown-it-task-lists.js';
import imgfigplg from '/static/js/public/markdown-it-image-figures.js';
import {
    container
} from '/static/js/public/mdit-plugin-container.js';
import markdownItHighlightjs from '/static/js/public/markdown-it-highlightjs.js'
async function render() {
    const md = window.markdownit({
        html: true,
        linkify: true,
        typographer: true
    })
    md.use(ruby);
    md.use(emoji);
    md.use(footnote);
    md.use(tasklistplg);
    md.use(imgfigplg);
    md.use(container);
    md.use(markdownItHighlightjs);
    
    const viewer = document.getElementById('markdownViewer');
    viewer.innerHTML = md.render(viewer.dataset.rawmd);
}

render();
