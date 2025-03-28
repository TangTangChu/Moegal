<?php
namespace Lib;

class HHelper{
    public static function isGET(): bool
    {
        return $_SERVER['REQUEST_METHOD'] === 'GET';
    }

    public static function isPOST(): bool
    {
        return $_SERVER['REQUEST_METHOD'] === 'POST';
    }

    public static function notFound()
    {
        header('HTTP/1.1 404 Not Found');
        header('Location: notfound');
        die();
    }
    public static function param()
    {
        // Invalid param
        header('HTTP/1.1 400 Bad Request');
        header('Content-Type: application/json');
        $data = [
            'code' => 400,
            'msg' => 'Invalid param'
        ];
        exit(json_encode($data));
    }

    public static function error()
    {
        header('HTTP/1.1 500 Internal Server Error');
        header('Content-Type: application/json');
        $data = [
            'code' => 500,
            'msg' => 'Internal Server Error'
        ];
        exit(json_encode($data));
    }
}
?>