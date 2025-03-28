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

if(!isset($_FILES['image'])){
    respond(400,'呜喵~主人忘记上传头像了啦！(つд⊂)');
}
if ($_FILES['image']['error'] !== UPLOAD_ERR_OK){
    respond(400,'上传时发生了意外！错误代码：'.$_FILES['image']['error'].' 的说~(＞△＜;)');
}
$uploadDir = UPLOADS_PATH . '/avatar/';
$filename = $_SESSION['UID'].'.webp';
$uploadFile = $uploadDir.$filename;

if (move_uploaded_file($_FILES['image']['tmp_name'], $uploadFile)) {
    if(SQL::updateUserProfilePhoto($_SESSION['UID'])){
        respond(200,'やった！新头像超可爱desu！(≧∇≦)ﾉ');
    }
    else{
        respond(500,'虽然头像上传成功，但同步到数据库时遇到了小精灵的干扰(´；ω；`)');
    }
}
else{
    respond(500,'后端酱好像闹别扭了...处理请求失败了啦！(つД`)');
}