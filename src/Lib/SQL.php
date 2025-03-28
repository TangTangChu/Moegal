<?php

namespace Lib;
require_once LIB_PATH.'/MarkdownHelper.php';

use Lib\MarkdownHelper;
use PDO;
use PDOException;

class SQL
{
    /** @var PDO PDO Connect */
    private static PDO $pdo;

    /** Create PDO Connect */
    private static function connect(): ?PDO
    {
        if (isset(self::$pdo)) return self::$pdo;
        $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8mb4";
        $options = [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ];
        try {
            $pdo = new PDO($dsn, DB_USER, DB_PASS, $options);
            self::$pdo = $pdo;
            return $pdo;
        } catch (PDOException $e) {
            Logger::log("Database connection error: " . $e->getMessage());
            return null;
        }
    }
    //用户相关
    public static function getHashedPasswordByUid($uid):?string{
        $sql = "select uPasswd from USERS where UID=?";
        $stmt = self::connect()->prepare($sql);
        
        $stmt->bindParam(1,$uid);
        if($stmt->execute()){
            return $stmt->fetchColumn();
        }
        else{
            return null;
        }
    }
    public static function getHashedPasswordByEmail($email):?array{
        $sql = "SELECT uPasswd,UID from USERS where uEmail=?";
        $stmt = self::connect()->prepare($sql);
        $stmt->bindParam(1,$email);
        $stmt->execute();
        if($result=$stmt->fetch()){
            return $result;
        }
        else{
            return null;
        }
    }
    public static function getUserInfo($uid):?array{
        $sql = "SELECT UID,uNickname,uProfileCover,uProfilePhoto,uEmail,uRegDateTime,uGroupTags from USERS where UID=?";
        $stmt = self::connect()->prepare($sql);
        $stmt->bindParam(1,$uid);
        if($stmt->execute()){
            return $stmt->fetch();
        }
        else{
            return NULL;
        }
    }
    public static function getUserBaseInfo($uid):?array{
        $sql = "SELECT UID,uNickname,uProfilePhoto,uProfileCover,uGroupTags from USERS where UID=?";
        $stmt = self::connect()->prepare($sql);
        $stmt->bindParam(1,$uid);
        if($stmt->execute()){
            if($r = $stmt->fetch()){
                return $r;
            }
        }
       return NULL;
    }
    public static function getNickname($uid):?string{
        $sql = "SELECT uNickname from USERS where UID=?";
        $stmt = self::connect()->prepare($sql);
        $stmt->bindParam(1,$uid);
        $stmt->execute();
        return $stmt->fetchColumn();
    }
    //获取用户组标签
    public static function getUserGroupTag($uid):?array{
        $sql = "SELECT uGroupTags from USERS where UID=?";
        $stmt = self::connect()->prepare($sql);
        $stmt->bindParam(1,$uid);
        $stmt->execute();
        $result = json_decode($stmt->fetchColumn(),true);
        if(isset($result['uGtags'])){
            return $result['uGtags'];
        }
        else{
            return NULL;
        }
    }
    public static function getUserArticles($uid):?array{
        $sql = "SELECT * FROM ARTICLES WHERE aUID=?";
        $stmt = self::connect()->prepare($sql);
        $stmt->execute([$uid]);
        return $stmt->fetchAll();
    }
    public static function getUserGals($uid):?array{
        $sql = "SELECT * FROM GALRES WHERE gUID=?";
        $stmt = self::connect()->prepare($sql);
        $stmt->execute([$uid]);
        return $stmt->fetchAll();
    }
    public static function getUserArticlesCount($uid):int{
        $sql = "SELECT COUNT(*) FROM ARTICLES WHERE aUID=?";
        $stmt = self::connect()->prepare($sql);
        $stmt->execute([$uid]);
        return $stmt->fetchColumn();
    }
    public static function getUserGalsCount($uid):int{
        $sql = "SELECT COUNT(*) FROM GALRES WHERE gUID=?";
        $stmt = self::connect()->prepare($sql);
        $stmt->execute([$uid]);
        return $stmt->fetchColumn();
    }
    public static function getUserCount():int{
        $stmt = self::connect()->query("SELECT COUNT(*) FROM USERS");
        return $stmt->fetchColumn();
    }
    public static function getAllUserInfo():array{
        $sql = "SELECT UID,uNickname,uProfilePhoto,uRegDateTime,uGroupTags FROM USERS";
        $stmt = self::connect()->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll();
    }
    public static function updateUserProfilePhoto($uid):bool{
        $sql="UPDATE USERS SET uProfilePhoto=? WHERE UID=?";
        $stmt= self::connect()->prepare($sql);
        return $stmt->execute(["/uploads/avatar/$uid.webp",$uid]);
    }
    public static function updateUserCover($uid,$cover):bool{
        $sql = "UPDATE USERS SET uProfileCover=? WHERE UID = ?";
        $stmt = self::connect()->prepare($sql);
        return $stmt->execute([$cover,$uid]);
    }
    public static function isEmailExist($emali):bool{
        $sql = "SELECT COUNT(*) FROM USERS WHERE uEmail = ?";
        $stmt = self::connect()->prepare($sql);
        $stmt->bindParam(1,$emali);
        $stmt->execute();
        if($stmt->fetchColumn()>0){
            return true;
        }
        else{
            return false;
        }
    }
    public static function isUIDExist($uid):bool{
        $sql = "SELECT COUNT(*) FROM USERS WHERE UID = ?";
        $stmt = self::connect()->prepare($sql);
        $stmt->bindParam(1,$uid);
        $stmt->execute();
        if($stmt->fetchColumn()>0){
            return true;
        }
        else{
            return false;
        }
    }
    public static function updateUserInfo($uid,$nickname,$email):bool{
        $sql = "UPDATE USERS SET uNickname=?,uEmail=? WHERE UID=?";
        $stmt = self::connect()->prepare($sql);
        return $stmt->execute([$nickname,$email,$uid]);
    }
    public static function updateUserPassword($uid,$passwd):bool{
        $sql = "UPDATE USERS SET uPasswd=? WHERE UID=?";
        $stmt = self::connect()->prepare($sql);
        return $stmt->execute([$passwd,$uid]);
    }
    public static function regUser($email,$nickname,$hashpasswd):bool{
        $sql="INSERT INTO USERS (uNickname,uEmail,uPasswd,uRegDateTime) VALUES (?,?,?,?)";
        $stmt = self::connect()->prepare($sql);
        $stmt->bindParam(1,$nickname);
        $stmt->bindParam(2,$email);
        $stmt->bindParam(3,$hashpasswd);
        $currenttimestamp = time();
        $stmt->bindParam(4,$currenttimestamp);
        if($stmt->execute()){
            return true;
        }
        else{
            return false;
        }
    }


    //图像相关
    public static function uploadImage($name,$author,$from,$desc,$uid,$path){
        $conn = self::connect();
        $conn->beginTransaction();
        $sql = "INSERT INTO IMGSTN (iName, iAuthor, iFrom, iDesc, iBy, iPath,iDateTime,iHistory) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $datetime = time();
        $stmt->execute([$name, $author, $from, $desc, $uid, $path,$datetime,json_encode([$datetime=>sprintf($uid."上传了图像")])]);
        
        $sql = "SELECT IID FROM IMGSTN WHERE iName=?";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(1, $name);
        $stmt->execute();
        $iid = $stmt->fetchColumn();
        $conn->commit();
        return $iid;
    }
    public static function updateImage($name,$author,$from,$desc,$uid){
        $conn = self::connect();
        $sql = "SELECT iHistory FROM IMGSTN WHERE iName = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(1, $name);
        $stmt->execute();
        $ihis = json_decode($stmt->fetchColumn(),true);
        if(json_last_error()){
            $ihis=[];
        }
        $ihis[time()]=$uid.'更新了图像';
        $ihisj = json_encode($ihis,JSON_UNESCAPED_UNICODE);
        $sql = "UPDATE IMGSTN SET iAuthor=?, iFrom=?, iDesc=?,iHistory=? WHERE iName = ?";
        $stmt = $conn->prepare($sql);
        return $stmt->execute([$author, $from, $desc,$ihisj,$name]);
    }
    public static function isImageExist($name){
        $conn = self::connect();
        $sql = "SELECT iBy,IID FROM IMGSTN WHERE iName = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(1, $name);
        $stmt->execute();
        
        return $stmt->fetch();    
    }
    public static function delImage($iid):bool{
        $file_path = HTML_PATH . self::getIMGPathByIID($iid);
        if (file_exists($file_path)){
            unlink($file_path);
        } 
        $sql = "DELETE FROM IMGSTN WHERE IID=?";
        $stmt = self::connect()->prepare($sql);
        return $stmt->execute([$iid]);    
    }
    //获取图片数量
    public static function getImageCount(): int {
        $stmt = self::connect()->query("SELECT COUNT(*) FROM IMGSTN");
        return (int)$stmt->fetchColumn();
    }
    //获取近期的图片
    public static function getRecentImages($offset):?array{
        if(($offset-1)*12+1>self::getImageCount()){
            return NULL;
        }
        else{
            $sql = "SELECT * FROM IMGSTN ORDER BY IID DESC LIMIT 12 OFFSET ?";
            $stmt = self::connect()->prepare($sql);
            $offs =($offset-1)*12;
            $stmt->bindParam(1,$offs);
            $stmt->execute();
            return $stmt->fetchAll();
        }
    }
    public static function getImageInfo($iid):?array{
        $sql = "SELECT * FROM IMGSTN WHERE IID=?";
        $stmt = self::connect()->prepare($sql);
        $stmt->bindParam(1,$iid);
        $stmt->execute();
        return $stmt->fetch();
    }
    public static function getIMGPathByIID($iid):?string{
        $sql = "SELECT iPath from IMGSTN where IID=?";
        $stmt = self::connect()->prepare($sql);
        $stmt->bindParam(1,$iid);
        if($stmt->execute()){
            return $stmt->fetchColumn();
        }
        else{
            return NULL;
        }
    }


    //文章相关
    public static function uploadArticle($uid,$title,$cover,$content,$isrp,$bylic):?int{
        $sql = "INSERT INTO ARTICLES (aUID,aTitle,aCover,aContent,aAbstract,aDateTime,aIsReprint,aLicense) VALUES (?,?,?,?,?,?,?,?)";
        $conn=self::connect();
        $stmt = $conn->prepare($sql);
        $currenttimestamp = time();
        $abstract = MarkdownHelper::extmd($content);
        if($stmt->execute([$uid,$title,$cover,$content,$abstract,$currenttimestamp,$isrp,$bylic])){
            $sql = "SELECT AID FROM ARTICLES WHERE aUID=? and aDateTime=?";
            $stmt= $conn->prepare($sql);
            $stmt->execute([$uid,$currenttimestamp]);
            return $stmt->fetchColumn();
        }
    }
    public static function getArticle($aid):?array{
        $sql = "SELECT * FROM ARTICLES WHERE AID=?";
        $stmt = self::connect()->prepare($sql);
        $stmt->execute([$aid]);
        return $stmt->fetch();
    }
    public static function incrementArticleViews($aid){
        $sql = "UPDATE ARTICLES SET aPageview=aPageview+1 WHERE AID=?";
        $stmt = self::connect()->prepare($sql);
        $stmt->execute([$aid]);
    }
    public static function getArticleTotalViews():int{
        $sql = "SELECT SUM(aPageview) FROM ARTICLES";
        $stmt = self::connect()->query($sql);
        return (int)$stmt->fetchColumn();
    }
    public static function getArticleCount():int{
        $stmt = self::connect()->query("SELECT COUNT(*) FROM ARTICLES");
        return (int)$stmt->fetchColumn();
    }
    public static function getRecentArticle():array{
        $sql = "SELECT * FROM ARTICLES ORDER BY AID DESC LIMIT 5";
        $stmt = self::connect()->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll();
    }
    public static function getArticlesByAIDRange($offset):?array{
        if(($offset-1)*10+1>self::getArticleCount()){
            return NULL;
        }
        else{
            $sql = "SELECT * FROM ARTICLES ORDER BY AID DESC LIMIT 10 OFFSET ?";
            $stmt = self::connect()->prepare($sql);
            $offs =($offset-1)*10;
            $stmt->bindParam(1,$offs);
            $stmt->execute();
            return $stmt->fetchAll();
        }
    }
    public static function getArticleRecentUser():array{
        $sql = "SELECT aUID FROM ARTICLES ORDER BY AID DESC LIMIT 5";
        $stmt = self::connect()->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll();
    }
    public static function getArticleComments($aid){
        $sql = "SELECT aComments FROM ARTICLES WHERE AID = ?";
        $stmt=self::connect()->prepare($sql);
        if($stmt->execute([$aid])){
            return $stmt->fetchColumn();
        }
        else{
            return NULL;
        }
    }
    public static function updateArticleComments($aid,$comment):bool{
        $comments = json_decode(self::getArticleComments($aid),true);
        $comments['comments'][]=$comment;
        $commentsJ=json_encode($comments,JSON_UNESCAPED_UNICODE);
        $sql = "UPDATE ARTICLES SET aComments=? WHERE AID=?";
        $stmt = self::connect()->prepare($sql);
        return $stmt->execute([$commentsJ,$aid]);
    }
    //gal资源相关
    public static function upGal($galdata,$uid,$galpath){
        $sql = "INSERT INTO GALRES (gName,gTranslation,gTranslationsAliases,gDeveloper,gReleased,gAbstract,gDesc,gCover,gUploadTime,gTag,gUID,gReslink,gDisplayName) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
        $conn=self::connect();
        $stmt=$conn->prepare($sql);
        $currenttimestamp = time();
        if($stmt->execute([$galdata['gal_name'],
                        $galdata['gal_name_zhsp'],
                        $galdata['gal_name_tralias'],
                        $galdata['gal_dev'],
                        $galdata['gal_released'],
                        $galdata['gal_abs'],
                        $galdata['gal_desc'],
                        $galdata['gal_cover'],
                        $currenttimestamp,
                        $galdata['gal_tags'],
                        $uid,
                        $galpath,
                        $galdata['gal_displayname']]))
        {
            $sql = "SELECT GID FROM GALRES WHERE gUID=? and gUploadTime=?";
            $stmt=$conn->prepare($sql);
            $stmt->execute([$uid,$currenttimestamp]);
            return $stmt->fetchColumn();
        }
        else{
            return false;
        }
    }
    public static function getGal($gid):?array{
        $sql = "SELECT * FROM GALRES WHERE GID=?";
        $stmt=self::connect()->prepare($sql);
        if($stmt->execute([$gid])){
            return $stmt->fetch();
        }
        else{
            return NULL;
        }
    }
    public static function getRecentGal():array{
        $sql = "SELECT * FROM GALRES ORDER BY GID DESC LIMIT 5";
        $stmt = self::connect()->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll();
    }
    public static function getGalCount():int{
        $stmt = self::connect()->query("SELECT COUNT(*) FROM GALRES");
        return (int)$stmt->fetchColumn();
    }
    public static function incrementGalDownloads($gid):bool{
        $sql = "UPDATE GALRES SET gDownloads=gDownloads+1 WHERE GID=?";
        $stmt = self::connect()->prepare($sql);
        return $stmt->execute([$gid]);
    }
    public static function getGalTotalDownloads():int{
        $sql = "SELECT SUM(gDownloads) FROM GALRES";
        $stmt = self::connect()->query($sql);
        return (int)$stmt->fetchColumn();
    }
    public static function getGalbyGIDRange($offset){
        if(($offset-1)*15+1>self::getGalCount()){
            return NULL;
        }
        else{
            $sql = "SELECT * FROM GALRES ORDER BY GID DESC LIMIT 15 OFFSET ?";
            $stmt = self::connect()->prepare($sql);
            $offs =($offset-1)*15;
            $stmt->bindParam(1,$offs);
            $stmt->execute();
            return $stmt->fetchAll();
        }
    }
    public static function getGalRecentUser(){
        $sql = "SELECT gUID FROM GALRES ORDER BY GID DESC LIMIT 5";
        $stmt = self::connect()->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll();
    }
}