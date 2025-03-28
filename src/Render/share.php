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
$result['display']['galCount']=SQL::getGalCount();
$result['display']['articleCount']=SQL::getArticleCount();
$result['display']['userCount']=SQL::getUserCount();
$result['display']['totalDownloads']=SQL::getGalTotalDownloads();
$result['display']['totalViews']=SQL::getArticleTotalViews();

echo $twig->render('share.twig', array_merge($selfinfo,$result));
?>