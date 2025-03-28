<?php

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once LIB_PATH . '/SQL.php';

use Lib\SQL;
use Twig\Environment;
use Twig\Loader\FilesystemLoader;

$loader = new FilesystemLoader(TEMPL_PATH);
$twig = new Environment($loader);

$selfinfo=[];
if(isset($_SESSION['UID'])){
    $selfinfo['self'] = SQL::getUserBaseInfo($_SESSION['UID']);
}

$result['display']['count'] = SQL::getUserCount();
$userlist = SQL::getAllUserInfo();
$result['display']['users'] = array_map(function($user) {
    $uGtas = json_decode($user['uGroupTags'],true);
    $user['uGCount']=SQL::getUserGalsCount($user['UID']);
    $user['uACount']=SQL::getUserArticlesCount($user['UID']);
    return $uGtas?array_merge($user,$uGtas):$user;
}, $userlist);

echo $twig->render('userlist.twig', array_merge($selfinfo,$result));