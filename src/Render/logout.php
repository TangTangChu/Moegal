<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
if(!isset($_SESSION['UID'])){
    header('location:/login');
    exit;
}
use Twig\Environment;
use Twig\Loader\FilesystemLoader;
use Lib\SQL;

$selfinfo['self'] = SQL::getUserBaseInfo($_SESSION['UID']);
$loader = new FilesystemLoader(TEMPL_PATH);
$twig = new Environment($loader);

echo $twig->render('logout.twig', $selfinfo);