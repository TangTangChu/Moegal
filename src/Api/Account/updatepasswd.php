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
if($data['oripasswd']==SQL::getHashedPasswordByUid($_SESSION['UID'])){
    if(SQL::updateUserPassword($_SESSION['UID'],$data['newpasswd'])){
        respond(200,'密码成功更新啦(๑•. •๑)！');
    }
    else{
        respond(500,'后端酱好像闹别扭了...处理请求失败了啦！(つД`)');
    }
}
else{
    respond(400,'唔~原密码好像不对哟(｡ ́︿ ̀｡)');
}