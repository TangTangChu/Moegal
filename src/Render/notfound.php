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
$result['tryurl']=$_GET['path'];
echo $twig->render('notfound.twig', array_merge($selfinfo,$result));
?>