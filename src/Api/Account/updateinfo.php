<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
use Lib\SQL;
$json = file_get_contents('php://input');
$data = json_decode($json,true);

function respond($code, $details)
{
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['code' => $code, 'details' => $details]);
    exit();
}
if(!isset($_SESSION['UID'])){
    respond(401,'(,,・ω・,,) 要先登录才能使用这个魔法呢~请到登录界面验证身份的说！');
}
if (json_last_error() !== JSON_ERROR_NONE) {
    respond(400, '呜哇！这个JSON好像被奇怪的魔法污染了(╯°□°）╯ 解析失败desu！');
}
if (SQL::isEmailExist($data['email'])&&$data['email']!==SQL::getUserInfo($_SESSION['UID'])['uEmail']) {
    respond(409, '啊啦~这个邮箱已经被其他主人注册过了呢(´･ω･`) 要换个邮箱试试吗？');
}
if(SQL::updateUserInfo($_SESSION['UID'],$data['nickname'],$data['email'])){
    respond(200,'(๑•̀ㅂ•́)و✧耶~资料成功更新啦');
}
else{
    respond(500,'后端酱好像闹别扭了...处理请求失败了啦！(つД`)');
}