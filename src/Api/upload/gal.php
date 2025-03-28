<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
use Lib\SQL;
$allowed_ext = ['zip','7z','rar','gz','tar','xz','bz2','iso','dmg','lzh'];
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

if (!isset($_FILES['gal']) || !isset($_POST['data'])) {
    respond(400, '无文件或缺少 JSON 数据，'.'文件'.(int)isset($_FILES['gal']).'data'.(int)isset($_POST['data']));
}

$file = $_FILES['gal'];
$data = json_decode($_POST['data'], true);
if ($file['error'] === UPLOAD_ERR_OK) {
    $fileExtension = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
    if(!in_array($fileExtension,$allowed_ext)){
        respond(415,'(｡•́︿•̀｡)唔这是不支持的文件类型啦，换一种好不好嘛 '.$fileExtension);
    }
    if (json_last_error() == JSON_ERROR_NONE) {
        if (
            !isset($data['gal_name']) ||
            !isset($data['gal_name_zhsp']) ||
            !isset($data['gal_abs']) ||
            !isset($data['gal_released']) ||
            !isset($data['gal_dev']) ||
            !isset($data['gal_tags']) ||
            !isset($data['gal_cover']) ||
            !isset($data['gal_desc'])||
            !isset($data['gal_displayname'])
        ) {
            respond(400, '(｡･ω･｡)ﾉ♡糟糕啦！提供的资料不完整呢，快补齐啦~');
        }
        $uploadDir = UPLOADS_PATH . '/galres/';
        $filename = md5($data['gal_name']) . '.' . $fileExtension;
        $uploadFile = $uploadDir . $filename;
        $webrelpath = '/uploads/galres/' . $filename;
        if(move_uploaded_file($file['tmp_name'],$uploadFile)){
            $data['gal_tags']=str_replace(' ','',$data['gal_tags']);
            if($gid=SQL::upGal($data,$_SESSION['UID'],$webrelpath)){
                respond(200,'哼，资源上传成功了。那就……那就勉强帮你跳转吧，别一副很期待的样子！',['gid'=>$gid]);
            }
            else{
                respond(500,'呜~资源虽已保存至服务器，但是后端酱罢工了啦~，还请重新上传吧！＞︿＜');
            }
        }
    }
}
