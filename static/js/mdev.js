const md = window.markdownit({
	html: true,
	linkify: true,
	typographer: true
})
//MD预览渲染部分
import {
	ruby
} from "/static/js/public/mdit-plugin-ruby.js";
import {
	footnote
} from "/static/js/public/mdit-plugin-footnote.js";
import {
	full as emoji
} from "/static/js/public/markdown-it-emoji.js";
import tasklistplg from "/static/js/public/markdown-it-task-lists.js";
import imgfigplg from "/static/js/public/markdown-it-image-figures.js";
import {
	container
} from "/static/js/public/mdit-plugin-container.js";
import markdownItHighlightjs from "/static/js/public/markdown-it-highlightjs.js"
md.use(ruby);
md.use(emoji);
md.use(footnote);
md.use(tasklistplg);
md.use(imgfigplg);
md.use(container);
md.use(markdownItHighlightjs);

//MD语法渲染部分
import highlightJs from "/static/js/public/highlight.js";
import markdown from "/static/js/public/highlightjs-markdown.min.js";
highlightJs.registerLanguage("markdown", markdown);

const rawMarkdown = document.querySelector('.markdowneditor .EV #rawmarkdown');
const editor = document.querySelector('.markdowneditor .EV #editor');
const preview = document.querySelector('.markdowneditor .EV #viewer');
const dialog_tips = document.getElementById('mdevtips');
document.querySelector('.markdowneditor .toolbar #tips').addEventListener('click',()=>{
	dialog_tips.open=true;
});
function syncRawMarkdown() {
	rawMarkdown.value = editor.innerText;
}

function saveCursorPosition() {
	const selection = window.getSelection();
	const range = selection.getRangeAt(0);
	const preCaretRange = range.cloneRange();
	preCaretRange.selectNodeContents(editor);
	preCaretRange.setEnd(range.endContainer, range.endOffset);
	return preCaretRange.toString().length;
}

function restoreCursorPosition(position) {
	const selection = window.getSelection();
	const range = document.createRange();
	let currentNode = null;
	let charCount = 0;

	function traverse(node) {
		if (node.nodeType === Node.TEXT_NODE) {
			const nextCharCount = charCount + node.length;
			if (position <= nextCharCount) {
				range.setStart(node, position - charCount);
				range.collapse(true);
				return true;
			}
			charCount = nextCharCount;
		} else {
			for (let child of node.childNodes) {
				if (traverse(child)) return true;
			}
		}
		return false;
	}

	traverse(editor);
	selection.removeAllRanges();
	selection.addRange(range);
}
// 保存滚动位置
function saveScrollPosition() {
	return {
		scrollTop: document.documentElement.scrollTop || document.body.scrollTop,
		scrollLeft: document.documentElement.scrollLeft || document.body.scrollLeft,
	};
}

// 恢复滚动位置
function restoreScrollPosition(position) {
	document.documentElement.scrollTop = document.body.scrollTop = position.scrollTop;
	document.documentElement.scrollLeft = document.body.scrollLeft = position.scrollLeft;
}

function getRawMarkdown() {
	return rawMarkdown.value;
}

let timeout;

function escapeHtml(unsafe) {
	return unsafe
		.replace(/&/g, "&amp;")
		.replace(/</g, "&lt;")
		.replace(/>/g, "&gt;")
		.replace(/"/g, "&quot;")
		.replace(/"/g, "&#039;");
}

function debounce(func, delay) {
	return function(...args) {
		clearTimeout(timeout);
		timeout = setTimeout(() => {
			func.apply(this, args);
		}, delay);
	};
}

const updatePreview = debounce(() => {
	const markdownText = getRawMarkdown();
	preview.innerHTML = md.render(markdownText);
}, 400);
editor.addEventListener("keydown", (event) => {
	if (event.key === "Enter") {
		event.preventDefault();

		const selection = window.getSelection();
		const range = selection.getRangeAt(0);
		const textNode = document.createTextNode("\n");
		range.insertNode(textNode);

		// 移动光标到换行符后
		range.setStartAfter(textNode);
		range.collapse(true);
		selection.removeAllRanges();
		selection.addRange(range);

		const inputEvent = new Event("input", {
			bubbles: true
		});
		editor.dispatchEvent(inputEvent);
	}
});
editor.addEventListener("input", () => {
	syncRawMarkdown();
	const cursorPosition = saveCursorPosition();
	const scrollPosition = saveScrollPosition();
	const code = rawMarkdown.value;
	const escapedCode = escapeHtml(code);
	editor.innerHTML = `<pre><code class="language-markdown">${escapedCode}</code></pre>`;
	highlightJs.highlightElement(editor.querySelector("code"));
	restoreCursorPosition(cursorPosition);
	restoreScrollPosition(scrollPosition);
	updatePreview();
});

//初始化用滴
syncRawMarkdown();
editor.innerHTML = `<pre><code class="language-markdown">${rawMarkdown.value}</code></pre>`;
highlightJs.highlightElement(editor.querySelector("code"));