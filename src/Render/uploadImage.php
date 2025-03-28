<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
if(!isset($_SESSION['UID'])){
    header('location:/login?redirect=/upload/img');
    exit;
}
use Twig\Environment;
use Twig\Loader\FilesystemLoader;
use Lib\SQL; 

require_once LIB_PATH . '/SQL.php'; 

$loader = new FilesystemLoader(TEMPL_PATH);
$twig = new Environment($loader);

$selfinfo=[];
if(isset($_SESSION['UID'])){
    $selfinfo['self'] = SQL::getUserBaseInfo($_SESSION['UID']);
}
echo $twig->render('uploadimg.twig', $selfinfo);

?>