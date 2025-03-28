<?php
namespace Lib;
class RouterHelper
{
    private static function respond_p($code, $details, $additionalData = []) {
        header('Content-Type: application/json');
        $response = ['code' => $code, 'details' => $details];
        if (!empty($additionalData)) {
            $response = array_merge($response, $additionalData);
        }
        echo json_encode($response,JSON_UNESCAPED_UNICODE);
        exit;
    }
    public static function router()
    {
        $requestPath = isset($_GET['path']) ? $_GET['path'] : '/home';
        if ($_SERVER['REQUEST_METHOD'] === 'GET') {
            $routes = [
                '/' => function() {
                    header('location:/home');
                },
                '/home' => function() {
                    return RENDER_PATH.'/home.php';
                },
                '/galres' => function() {
                    return RENDER_PATH.'/galres.php';
                },
                '/galres/show' => function() {
                    return RENDER_PATH.'/galresContent.php';
                },
                '/article' => function() {
                    return RENDER_PATH.'/article.php';
                },
                '/article/show' => function() {
                    return RENDER_PATH.'/articleContent.php';
                },
                '/login' => function() {
                    return RENDER_PATH.'/login.php';
                },
                '/reg' => function() {
                    return RENDER_PATH.'/reg.php';
                },
                '/user' => function(){
                    return RENDER_PATH.'/user.php';
                },
                '/userlist' => function(){
                    return RENDER_PATH.'/userlist.php';
                },
                '/logout' => function() {
                    return RENDER_PATH.'/logout.php';
                },
                '/share' => function() {
                    return RENDER_PATH.'/share.php';
                },
                '/notfound' => function() {
                    return RENDER_PATH.'/notfound.php';
                },
                '/share/gal' => function() {
                    return RENDER_PATH.'/shareGal.php';
                },
                '/share/article' => function() {
                    return RENDER_PATH.'/shareArticle.php';
                },
                '/imgstn' => function() {
                    return RENDER_PATH.'/imgstn.php';
                },
                '/imgstn/detail' => function() {
                    return RENDER_PATH.'/imgstnd.php';
                },
                '/upload/img' => function() {
                    return RENDER_PATH.'/uploadImage.php';
                },
        ];
        
            if (array_key_exists($requestPath, $routes)) {
                $res =  $routes[$requestPath]();
                if(file_exists($res)){
                    require_once $res;
                }
                else{
                    require_once RENDER_PATH.'/notfound.php';
                }
            }
            else {
                require_once RENDER_PATH.'/notfound.php';
            }
        } 
        else if($_SERVER['REQUEST_METHOD'] === 'POST'){
             //API路由
            $routes = [
                '/api/account/login' => function() {
                    return API_PATH.'/Account/login.php';
                },
                '/api/account/logout' => function() {
                    return API_PATH.'/Account/logout.php';
                },
                '/api/account/reg' => function() {
                    return API_PATH.'/Account/reg.php';
                },
                '/api/account/changecover' => function() {
                    return API_PATH.'/Account/changecover.php';
                },
                '/api/account/updateinfo' => function() {
                    return API_PATH.'/Account/updateinfo.php';
                },
                '/api/account/updatepasswd' => function() {
                    return API_PATH.'/Account/updatepasswd.php';
                },
                '/api/account/changeavatar' => function() {
                    return API_PATH.'/Account/changeavatar.php';
                },
                '/api/image/getImgPath' => function() {
                    return API_PATH.'/Image/getImgPath.php';
                },
                '/api/image/delimage' => function() {
                    return API_PATH.'/Image/delImage.php';
                },
                '/api/upload/img' => function() {
                    return API_PATH.'/upload/img.php';
                },
                '/api/upload/gal' => function() {
                    return API_PATH.'/upload/gal.php';
                },
                '/api/upload/article' => function() {
                    return API_PATH.'/upload/article.php';
                },
                '/api/stats/articleview' => function() {
                    return API_PATH.'/stats/articleview.php';
                },
                '/api/stats/articleview' => function() {
                    return API_PATH.'/stats/articleview.php';
                },
                '/api/stats/galdownloads' => function() {
                    return API_PATH.'/stats/galDownloads.php';
                },
                '/api/article/comment' => function() {
                    return API_PATH.'/Articles/comment.php';
                }];
                if (array_key_exists($requestPath, $routes)) {
                    $res =  $routes[$requestPath]();
                    if(file_exists($res)){
                        require_once $res;
                    }
                    else{
                        self::respond_p(404,'むむむ...请求的API好像不存在desu(´･ω･) 是不是哪里搞错了呢？`');
                    }
                }
                else {
                    self::respond_p(404,'むむむ...请求的API好像不存在desu(´･ω･) 是不是哪里搞错了呢？`');
                }
        }
        else {
            self::respond_p(405,
                'あれれ？请求方式好像搞错了呢(⊙_⊙) 要用GET或POST才行哦~',
            [
                'RequestMethod' => $_SERVER['REQUEST_METHOD'],
                'Note' => '当前使用的魔法咒语：'.$_SERVER['REQUEST_METHOD'].' 是不被允许的desu(´･ω･`)'
            ]);
        }
}
    
}
?>