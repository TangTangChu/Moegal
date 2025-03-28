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
if(isset($_GET['gid'])){
    $result['display']=SQL::getGal($_GET['gid']);
    $result['display']['gTagarray']=explode('|',$result['display']['gTag']);
    $result['display']['gSize']=round(filesize(HTML_PATH.$result['display']['gReslink'])/1048576,3);
    $result['display']['uNickname']=SQL::getUserBaseInfo($result['display']['gUID'])['uNickname'];
    echo $twig->render('galrescontent.twig', array_merge($selfinfo,$result));
}
else{
    echo $twig->render('notfound.twig',array_merge($selfinfo,['tryurl'=>$_GET['path']]));
}
?>