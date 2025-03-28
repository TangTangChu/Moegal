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
$result['display']['count']=SQL::getGalCount();
$result['more']['sumpage']=ceil(($result['display']['count'])/10);
$result['display']['galList']=SQL::getGalbyGIDRange($result['more']['index']);

echo $twig->render('galres.twig', array_merge($selfinfo,$result));
?>