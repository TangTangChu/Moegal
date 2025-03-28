<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
use Twig\Environment;
use Twig\Loader\FilesystemLoader;
require_once LIB_PATH . '/SQL.php'; 
use Lib\SQL; 
$loader = new FilesystemLoader(TEMPL_PATH);
$twig = new Environment($loader);

$selfinfo=[];
if(isset($_SESSION['UID'])){
    $selfinfo['self'] = SQL::getUserBaseInfo($_SESSION['UID']);
}

$result['more']['index'] = (isset($_GET['index'])) ? $_GET['index'] : 1 ;
$result['display']['count']=SQL::getArticleCount();
$result['more']['sumpage']=ceil(($result['display']['count'])/4);
$result['display']['artclist']=SQL::getArticlesByAIDRange($result['more']['index']);

$result['display']['artclist'] = array_map(function($article) {
    return array_merge($article, SQL::getUserBaseInfo($article['aUID']));
}, $result['display']['artclist']);
if(json_last_error() !== JSON_ERROR_NONE && $result['article']['aComments']!==NULL){
    $result['article']['aComments'] = array_map(function($comment){
        return array_merge($comment,SQL::getUserBaseInfo($comment['UID']));
    },$result['article']['aComments']);
}
echo $twig->render('article.twig', array_merge($selfinfo,$result));
?>