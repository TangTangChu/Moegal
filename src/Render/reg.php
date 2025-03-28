<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
use Twig\Environment;
use Twig\Loader\FilesystemLoader;

$loader = new FilesystemLoader(TEMPL_PATH);
$twig = new Environment($loader);

echo $twig->render('reg.twig', []);
?>