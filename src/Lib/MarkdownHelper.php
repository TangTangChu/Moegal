<?php

namespace Lib;

class MarkdownHelper{
    public static function extmd($markdown):string{
        $text = preg_replace('/(^|\n)(#{1,6}.*)(\n|$)/', "\n\n", $markdown);
        $text = preg_replace('/-.*\n/', "\n", $text);
        $text = preg_replace('/\*\*(.*?)\*\*/', '$1', $text);
        $text = preg_replace('/\*(.*?)\*/', '$1', $text);

        $text = preg_replace('/\n\s*\n/', "\n\n", $text);
        $text = preg_replace('/\n+/', "\n", $text);
        $text = trim($text);
        return mb_substr($text,0,200,'utf-8');
    }
}