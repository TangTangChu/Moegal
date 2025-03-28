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
if(isset($_GET['iid'])){
    $img = SQL::getImageInfo($_GET['iid']);
    $result['img']=$img;
    $result['img']['iHistoryJ']=json_decode($img['iHistory'],true);
    $result['img']['iSize']=round(filesize(HTML_PATH.$result['img']['iPath'])/1048576,3);
    $result['redirect']='/imgstn/detail?iid='.$_GET['iid'];
    $result['img']['uNickname']=SQL::getUserBaseInfo($img['iBy'])['uNickname'];
}
else{
    $result['redirect']='/imgstn';
}

echo $twig->render('imgstnd.twig', array_merge($selfinfo,$result));
?>