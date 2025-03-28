<?php

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once LIB_PATH . '/Account.php';
use Lib\Account;
use Lib\SQL;

function respond($code, $details)
{
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['code' => $code, 'details' => $details]);
    exit();
}

if (Account::isLogin()) {
    respond(409, 'もう～主人已经登录了啦(。-`ω´-) 不可以重复注册的说！');
}

$json = file_get_contents('php://input');
$data = json_decode($json);

if (json_last_error() !== JSON_ERROR_NONE) {
    respond(400, '呜哇！这个JSON好像被奇怪的魔法污染了(╯°□°）╯ 解析失败desu！');
}

if (SQL::isEmailExist($data->email)) {
    respond(409, '啊啦~这个邮箱已经被其他主人注册过了呢(´･ω･`) 要换个邮箱试试吗？');
}

if (mb_strlen($data->nickname) > 12 || mb_strlen($data->nickname) < 1) {
    respond(422, '昵称要在1-12个字符之间哦(｀・ω・´) 太长或太短都不行呢~');
}

if (SQL::regUser($data->email, $data->nickname, $data->passwd)) {
    respond(200, 'やったー！(ﾉ◕ヮ◕)ﾉ*:･ﾟ✧ 注册成功！欢迎加入我们的世界！');
} else {
    respond(500, '呜...注册魔法好像出问题了(´；ω；｀) 一定是哪里搞错了...');
}

?>