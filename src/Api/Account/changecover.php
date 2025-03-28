<?php

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
use Lib\SQL;

function respond($code, $details)
{
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['code' => $code, 'details' => $details]);
    exit();
}

if (!isset($_SESSION['UID'])) {
    respond(401, '(,,・ω・,,) 要先登录才能使用这个魔法呢~请到登录界面验证身份的说！');
}
if (!isset($_POST['newcover'])) {
    respond(400, '呜喵~主人忘记提供封面路径了');
}
if (SQL::updateUserCover($_SESSION['UID'], $_POST['newcover'])) {
    respond(200, '哼！虽然很麻烦，但还是帮你换好背景了啦！(｀・ω・´)');
}
