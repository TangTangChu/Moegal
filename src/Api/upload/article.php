<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
use Lib\SQL;
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

$json = file_get_contents('php://input');
$data = json_decode($json, true);

if (json_last_error() !== JSON_ERROR_NONE) {
    respond(400, '呜哇！这个JSON好像被奇怪的魔法污染了(╯°□°）╯ 解析失败desu！');
}

$isrep = $data['artc_isrep'] ? 1 : 0;
if (
    $aid = SQL::uploadArticle(
        $_SESSION['UID'],
        trim($data['artc_title']),
        $data['artc_cover'],
        $data['artc_content'],
        $isrep,
        (int) $data['artc_bylic']
    )
) {
    respond(200, '哼，文章上传成功了。那就……那就勉强带你跳转到文章页吧，别一副很期待的样子！', ['aid' => $aid]);
}
