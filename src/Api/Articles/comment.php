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

if(!isset($_SESSION['UID'])){
    respond(401,'(,,・ω・,,) 要先登录才能使用这个魔法呢~请到登录界面验证身份的说！');
}
if(!isset($_POST['aid'])){
    respond(400,'似乎没有指定aid呢＞︿＜……');
}
if(!isset($_POST['comment'])||mb_strlen($_POST['comment']<1)){
    respond(400,'似乎没有评论内容呢＞︿＜……');
}
$comment=['UID'=>$_SESSION['UID'],'time'=>time(),'content'=>$_POST['comment']];
if(SQL::updateArticleComments($_POST['aid'],$comment)){
    respond(200,'评论成功啦！刷新页面可见');
}
else{
    respond(500,'后端酱罢工啦，无法处理评论！');
}


