<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
use Twig\Environment;
use Twig\Loader\FilesystemLoader;
use Lib\SQL;

$loader = new FilesystemLoader(TEMPL_PATH);
$twig = new Environment($loader);

$selfinfo=[];
if(isset($_SESSION['UID'])){
    $selfinfo['self'] = SQL::getUserBaseInfo($_SESSION['UID']);
}
$artclist = SQL::getRecentArticle();
$galList = SQL::getRecentGal();
$result['galList']=$galList;

$result['articleList'] = array_map(function($article) {
    return array_merge($article, SQL::getUserBaseInfo($article['aUID']));
}, $artclist);

$uids1= array_column(SQL::getGalRecentUser(),'gUID');
$uids2 = array_column(SQL::getArticleRecentUser(),'aUID');
$uids = array_unique(array_merge($uids1,$uids2));
foreach($uids as $uid){
    $result['RecentActiveUsers'][]=array_merge(['UID'=>$uid],SQL::getUserBaseInfo($uid));
}

echo $twig->render('home.twig', array_merge($selfinfo,$result));
?>