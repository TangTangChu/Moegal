<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
if(isset($_SESSION['UID'])){
    header('location:/logout');
    exit;
}
use Twig\Environment;
use Twig\Loader\FilesystemLoader;

$loader = new FilesystemLoader(TEMPL_PATH);
$twig = new Environment($loader);

echo $twig->render('login.twig', []);
?>