<?php

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

if (!isset($_SESSION['UID']) && !isset($_GET['uid'])) {
    header('Location: /login');
    exit();
}

require_once LIB_PATH . '/SQL.php';

use Lib\SQL;
use Twig\Environment;
use Twig\Loader\FilesystemLoader;

$loader = new FilesystemLoader(TEMPL_PATH);
$twig = new Environment($loader);

$uid = isset($_GET['uid']) ? filter_input(INPUT_GET, 'uid', FILTER_VALIDATE_INT) : null;

// 如果没有提供 uid 参数，默认使用当前登录用户的 UID
if ($uid === null) {
    $uid = $_SESSION['UID'];
}

if (!SQL::isUIDExist($uid)) {
    header('Location: /notfound');
    exit();
}

$selfinfo = [];
$result = [];
if(isset($_SESSION['UID'])){
    $selfinfo['self']=SQL::getUserInfo($_SESSION['UID']);
    $selfinfo['isself'] = ($_SESSION['UID'] == $uid) ? 1 : 0;
}
$result['display'] = SQL::getUserInfo($uid);
if($result['display']['uGroupTags']!=NULL){
    $result['display']['uGtags']=json_decode($result['display']['uGroupTags'],true)['uGtags'];
}
$result['display']['galList']=SQL::getUserGals($uid);
$result['display']['articleList']=SQL::getUserArticles($uid);
echo $twig->render('user.twig', array_merge($selfinfo, $result));

?>