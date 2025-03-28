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

if(!isset($_POST['iid'])){
    respond(400,'呜喵~主人，请先提交图片的IID哦~(＞﹏＜)');
}
if(!isset($_SESSION['UID'])){
    respond(401,'(,,・ω・,,) 要先登录才能使用这个魔法呢~请到登录界面验证身份的说！');
}
$data = SQL::getImageInfo($_POST['iid']);
if(isset($data['iBy'])){
    if($_SESSION['UID']==$data['iBy']||$_SESSION['typ']=='admin'){
        if(SQL::delImage($_POST['iid'])){
            respond(200,'✧*｡٩(ˊᗜˋ*)و✧*｡ 图片已经成功分解成星尘啦~');
        }
        else{
            respond(500,'(´；ω；`) 明明已经努力执行了...但删除协议好像被什么干扰了！');
        }
    }
    else{
        respond(403,'QAQ 这个操作需要管理员或上传者权限的说~禁止越权操作哦！');
    }
}
else{
    respond(404,'嘤嘤嘤~没有找到这张图片的说…(；´д｀)ゞ');
}
