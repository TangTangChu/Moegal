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
$index = (isset($_GET['index'])) ? $_GET['index'] : 1 ;
$listimg = SQL::getRecentImages($index);
$result['imglist']=$listimg;
$result['more']['index']=$index;
$result['more']['sumpage']=ceil((SQL::getImageCount())/12);
echo $twig->render('imgstn.twig', array_merge($selfinfo,$result));
?>