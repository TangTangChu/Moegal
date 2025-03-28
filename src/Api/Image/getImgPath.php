<?php
use Lib\SQL;

function respond($code, $details) {
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['code' => $code, 'details' => $details]);
    exit;
}


    if(isset($_POST['iid'])){
        if($res=SQL::getIMGPathByIID($_POST['iid'])){
            respond(200,$res);
        }
        else{
            respond(404,'(｡ ́︿ ̀｡)呜呜，IID对应的资源不存在耶~');
        }
    }
    else{
        respond(400,'哼，连IID都不提供，还想怎么样？真是的！');
    }


?>