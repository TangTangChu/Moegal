<?php

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once LIB_PATH . '/Account.php';
use Lib\Account;

function respond($code, $details)
{
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['code' => $code, 'details' => $details]);
    exit();
}
$json = file_get_contents('php://input');
$data = json_decode($json);

if (Account::isLogin()) {
    respond(409, '诶嘿~主人已经登录了啦(。・ω・。) 不需要重复登录的说~');
}

if (json_last_error() !== JSON_ERROR_NONE) {
    respond(400, '呜哇！这个JSON数据好像坏掉了呢(╯°□°）╯ 是不是被奇怪的魔法干扰了？');
}

if (Account::verify($data->user, $data->passwd)) {
    respond(200, 'Ciallo～(∠・ω< )⌒★ 欢迎回来，主人！登录成功desu！');
} else {
    respond(401, '呜...账号或密码好像不太对呢(´;ω;`) 要再检查一下吗？');
}

?>