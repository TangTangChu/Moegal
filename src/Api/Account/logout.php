<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

function respond($code, $details)
{
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['code' => $code, 'details' => $details]);
    exit();
}
if (isset($_SESSION['UID'])) {
    try {
        session_unset();
        session_destroy();
        setcookie('PHPSESSID', '', time() - 10, '/');
        respond(200,'じゃね～(´• ω •`)ﾉ 主人已经安全登出啦~期待下次再见哦！');
    } catch (Exception $ex) {
        respond(500,'呜哇！注销魔法好像失效了(´；ω；｀) 一定是哪里出了问题...');
    }
} else {
    respond(400,'もう～バカ！(╯°□°)╯ 明明还没有登录的说，不要随便请求注销啦！');
}