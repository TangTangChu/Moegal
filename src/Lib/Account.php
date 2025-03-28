<?php
namespace Lib;
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
use Lib\SQL;
class Account{
    public static function isValidEmail($email) {
        return filter_var($email, FILTER_VALIDATE_EMAIL) !== false;
    }
    public static function isLogin():bool{
        return isset($_SESSION['UID']);
    }
    public static function isAdmin():bool{
        if(isset($_SESSION['typ'])){
            return $_SESSION['typ']=='admin';
        }
        return false;
    }
    public static function isAdminByUID($uid):bool{
        $tag = SQL::getUserGroupTag($uid);
        if(!$tag){
            return false;
        }
        return in_array('众神眷恋的幻想乡',$tag);
    }
    public static function verify($user,$passwd):bool{

        if (self::isValidEmail($user)) {
            $data = SQL::getHashedPasswordByEmail($user);
            $uid = $data['UID'] ?? null;
            $hashedPassword = $data['uPasswd'] ?? null;
        } else {
            $uid = $user;
            $hashedPassword = SQL::getHashedPasswordByUid($user);
        }

        if ($hashedPassword && md5($passwd)===$hashedPassword) {
            self::setSession($uid);
            return true;
        }
        return false;
    }
    private static function setSession(int $uid): void
    {
        $_SESSION['UID'] = $uid;
        if (self::isAdminByUID($uid)) {
            $_SESSION['typ'] = 'admin';
        }
    }
}

?>