<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
use Twig\Environment;
use Twig\Loader\FilesystemLoader;
require_once LIB_PATH . '/SQL.php'; 
use Lib\SQL; 
$loader = new FilesystemLoader(TEMPL_PATH);
$twig = new Environment($loader);
$result=[];
$selfinfo=[];
if(isset($_SESSION['UID'])){
    $selfinfo['self'] = SQL::getUserBaseInfo($_SESSION['UID']);
}
if(isset($_GET['aid'])){
    $article = SQL::getArticle($_GET['aid']);
    $result['article']=$article;
    $result['article']['Nickname']=SQL::getUserBaseInfo($article['aUID'])['uNickname'];
    $result['article']['aComments'] = json_decode($article['aComments'],true);
    if(json_last_error() == JSON_ERROR_NONE && $result['article']['aComments']['comments']!=NULL){
        $result['article']['aComments']['comments'] = array_map(function($comment){
            $tpm = array_merge($comment,SQL::getUserBaseInfo($comment['UID']));
            if($tpm['uGroupTags']!=NULL){
                $tpm['uGtags']=json_decode($tpm['uGroupTags'],true)['uGtags'];
            }
            return $tpm;
        },$result['article']['aComments']['comments']);
    }
    echo $twig->render('articlecontent.twig', array_merge($selfinfo,$result));
}
else{
    $r = array_merge(['tryurl'=>$_GET['path'],$selfinfo]);
    echo $twig->render('notfound.twig',$r);
}

?>