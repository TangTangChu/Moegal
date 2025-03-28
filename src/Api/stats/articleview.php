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

if(isset($_POST['aid'])){
    SQL::incrementArticleViews($_POST['aid']);
    respond(200,'哦呼~浏览量+1,o(〃＾▽＾〃)o');
}
else{
    respond(400,'似乎没有提供AID呢');
}
