import {snackbarshow} from '/static/js/public/snackbarshow.js';

async function Traversalimg(){
    const imglist = document.querySelectorAll('.imgstn-imgbox img');
    imglist.forEach(async function(img){
        try{
            const resp = await fetch(img.dataset.url);
            if(!resp.ok){
                throw new Error('むむむ...请求失败desu！(。>︿<)_θ 错误代码：'+resp.status+' 的说~');
            }
            const fileblob = await resp.blob();
            const fileurl = URL.createObjectURL(fileblob);
            img.src=fileurl;
            
            img.onload=()=>{
                img.nextElementSibling.remove();
                URL.revokeObjectURL(fileurl);
                console.log('嘿咻~成功销毁'+fileurl);
            };
        }
        catch(err){
            snackbarshow(err.message);
            console.log(err.message);
        }
    });
}

Traversalimg();
