<?php

use Lib\SQL;
function respond($code, $details, $additionalData = []) {
    header('Content-Type: application/json');
    $response = ['code' => $code, 'details' => $details];
    if (!empty($additionalData)) {
        $response = array_merge($response, $additionalData);
    }
    echo json_encode($response);
    exit;
}

if(isset($_POST['gid'])){
    SQL::incrementGalDownloads($_POST['gid']);
    respond(200,'哦呼~下载量+1,o(〃＾▽＾〃)o');
}
else{
    respond(400,'似乎没有提供GID呢');
}
