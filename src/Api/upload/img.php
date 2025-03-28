<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
use Lib\SQL;
$allowed_ext = ['.zip','.7z','.rar','.gz','.tar','.xz','.bz2','.iso','.dmg','.lzh'];
function respond($code, $details, $additionalData = [])
{
    header('Content-Type: application/json');
    $response = ['code' => $code, 'details' => $details];
    if (!empty($additionalData)) {
        $response = array_merge($response, $additionalData);
    }
    echo json_encode($response);
    exit();
}

if (!isset($_SESSION['UID'])) {
    respond(401, '(,,・ω・,,) 要先登录才能使用这个魔法呢~请到登录界面验证身份的说！');
}

if (isset($_FILES['image']) && isset($_POST['data'])) {
    $file = $_FILES['image'];
    $jsonData = json_decode($_POST['data'], true);

    if ($file['error'] === UPLOAD_ERR_OK) {
        if (isset($jsonData['name']) && !empty($jsonData['name'])) {
            $uploadDir = UPLOADS_PATH . '/images/';
            $filename = str_replace(' ', '_', $jsonData['name']) . '.webp';
            $uploadFile = $uploadDir . $filename;
            $webrelpath = '/uploads/images/' . $filename;

            $exist = SQL::isImageExist($jsonData['name']);
            if($exist){
                if(!isset($_SESSION['UID'])&&$_SESSION['typ']!='admin'&&$exist['iBy']!=$_SESSION['UID']){
                    respond(403,'むむむ...这个操作需要管理员权限或者图片上传者权限desu(´･ω･)');
                }
                if (move_uploaded_file($file['tmp_name'], $uploadFile)){
                    if(SQL::updateImage($jsonData['name'],$jsonData['author'],$jsonData['from'],$jsonData['desc'],$_SESSION['UID'])){
                        respond(200,'图像*更新*魔法施展成功！✨ 数据已经安全抵达目的地！');
                    }
                    else{
                        respond(500,'呜~文件已成功上传，但是后端酱罢工啦，请重新上传吧！＞︿＜');
                    }
                }
            }
            if (move_uploaded_file($file['tmp_name'], $uploadFile)) {
                if (
                    $iid = SQL::uploadImage(
                        $jsonData['name'],
                        $jsonData['author'],
                        $jsonData['from'],
                        $jsonData['desc'],
                        $_SESSION['UID'],
                        $webrelpath
                    )
                ) {
                    respond(200, '图像传送魔法施展成功！✨ 数据已经安全抵达目的地！', [
                        'path' => $webrelpath,
                        'iid' => $iid,
                    ]);
                } else {
                    respond(
                        500,
                        '呜~文件已成功上传，但是后端酱罢工啦，请重新上传吧！＞︿＜'
                    );
                }
            } else {
                respond(500, 'あれれ？文件上传好像失败了desu(´･ω･) 要不再试一次看看？: ' . $uploadFile);
            }
        } else {
            respond(400, 'むむむ...主人少填了一些字段desu(´･ω･) 要不再检查一下？');
        }
    } else {
        respond(400, '呜~上传魔法被打断了呢……: ' . $file['error']);
    }
} else {
    respond(400, '呜喵！主人忘记上传文件或者Json数据了啦！(つд⊂)');
}

?>
