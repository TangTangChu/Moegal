import {snackbarshow} from '/static/js/public/snackbarshow.js';
import imageCompression from '/static/js/public/browser-image-compression.js';
import { hex_md5 } from '/static/js/public/md5.js';
import Cropper from '/static/js/public/cropper.esm.js';

const changecover = document.getElementById('changecover');
const btn_changeavatar = document.getElementById('user-st-changavater');
const btn_basesubmit = document.getElementById('user-st-baseinfo-submit');
const btn_cpsubmit = document.getElementById('user-st-cp-submit');
const dialog_ccv = document.getElementById('change_userbg');
const bg = document.getElementById('ubg');
const dialog_confirm = document.querySelector('#change_userbg #dialog_confirm');
const st_nickname = document.getElementById('user-st-nickname');
const st_email = document.getElementById('user-st-email');
const st_oripasswd = document.getElementById('user-st-oripasswd');
const st_newpasswd = document.getElementById('user-st-newpasswd');
const st_tnewpasswd = document.getElementById('user-st-tnewpasswd');
const input_avatar = document.getElementById('input_avatar')
const img_newavatar = document.getElementById('avataredit');
const aec = document.querySelector('.aecontainer');
const dialog_cancel = document.getElementById('dialog_cancel');
let cropper1;
changecover.addEventListener('click',change_cover);
dialog_confirm.addEventListener('click',()=>{dialog_ccv.open=false;update_cover();})
dialog_cancel.addEventListener('click',()=>{dialog_ccv.open=false;})
btn_basesubmit.addEventListener('click',update_baseinfo);
btn_cpsubmit.addEventListener('click',update_passwd);
btn_changeavatar.addEventListener('click',upload_avatar);
input_avatar.addEventListener('change',(e)=>{
    if(e.target.files.length!==0){
        const reader = new FileReader();
        reader.onload = function (e) {
            img_newavatar.src = e.target.result;
            img_newavatar.onload=new function(){
                aec.style.height='420px';
                cropper1 = new Cropper(img_newavatar,{
                    aspectRatio: 1 / 1,
                    minCropBoxHeight:100,
                    viewMode:1,
                    movable: true, // 是否允许剪裁框移动
                    zoomable: true, // 是否允许缩放图片
                    guides: true, // 是否显示剪裁框虚线
                    background: true, // 是否显示背景网格
                    cropBoxMovable: true, // 是否允许剪裁框拖动
                    cropBoxResizable: true, // 是否允许剪裁框缩放
                });
            }
        };
        reader.readAsDataURL(e.target.files[0]);
    }
});
async function change_cover(){
    dialog_ccv.open=true;
}


// 设置按钮的加载状态
function setButtonLoading(button, isLoading, text = '') {
    if (isLoading) {
        button.setAttribute('loading', '');
        button.setAttribute('disabled', '');
    } else {
        button.removeAttribute('loading');
        button.removeAttribute('disabled');
    }
    if (text) button.innerHTML = text;
}

// 更新背景
async function update_cover() {
    let imgpath = document.querySelector('.imgselector-sel-target #imgselector-mtarget').value;

    if (!imgpath) {
        snackbarshow('(｡･ω･｡)ﾉ♡哎呀，还没有选择图像呢');
        return;
    }

    try {
        const fd = new FormData();
        fd.append('newcover', imgpath);
        const resp = await fetch('/api/account/changecover', {
            'method': 'POST',
            'body': fd
        });

        if (!resp.ok) throw new Error('むむむ...请求失败desu！(。>︿<)_θ 错误代码：'+resp.status+' 的说~');

        const rdata = await resp.json();
        if (rdata.code === 200) {
            snackbarshow(rdata.details);
            bg.src = imgpath;
        } else {
            throw new Error(rdata.details);
        }
    } catch (err) {
        console.error(err.message);
        snackbarshow(err.message);
    }
}

// 上传头像
async function upload_avatar() {
    if (!cropper1) {
        snackbarshow('呜~图像剪裁器还没有加载出来呢');
        return;
    }

    const options = { useWebWorker: true, fileType: 'image/webp' };

    try {
        setButtonLoading(btn_changeavatar, true, '图像编码中');

        const canvas = cropper1.getCroppedCanvas();
        const blobfile = await new Promise((resolve) => canvas.toBlob(resolve));
        const cmsfile = await imageCompression(blobfile, options);

        const fd = new FormData();
        fd.append('image', cmsfile);

        setButtonLoading(btn_changeavatar, true, '上传中');

        const resp = await fetch('/api/account/changeavatar', {
            'method': 'POST',
            'body': fd
        });

        if (!resp.ok) throw new Error('むむむ...请求失败desu！(。>︿<)_θ 错误代码：'+resp.status+' 的说~');

        const rdata = await resp.json();
        if (rdata.code === 200) {
            snackbarshow(rdata.details);
            setButtonLoading(btn_changeavatar, false, '头像上传成功');
        } else {
            throw new Error(rdata.details);
        }
    } catch (err) {
        console.error('呜更改头像失败了呢: ' + err.message);
        snackbarshow('呜更改头像失败了呢:' + err.message);
        setButtonLoading(btn_changeavatar, false, '上传失败');
    }
}

// 更新基本信息
async function update_baseinfo() {
    if (!st_email.validity.valid || !st_nickname.validity.valid || st_nickname.value.trim() === '') {
        snackbarshow(' 唔~没办法修改资料呢。要好好确认一下，资料是不是符合要求呀');
        return;
    }

    setButtonLoading(btn_basesubmit, true);

    const sendData = { 'email': st_email.value, 'nickname': st_nickname.value };

    try {
        const resp = await fetch('/api/account/updateinfo', {
            'method': 'POST',
            'headers': { 'Content-Type': 'application/json' },
            'body': JSON.stringify(sendData)
        });

        if (!resp.ok) throw new Error('むむむ...请求失败desu！(。>︿<)_θ 错误代码：'+resp.status+' 的说~');

        const rdata = await resp.json();
        if (rdata.code === 200) {
            snackbarshow(rdata.details);
        } else {
            throw new Error(rdata.details);
        }
    } catch (err) {
        console.error(err.message);
        snackbarshow('Error: ' + err.message);
    } finally {
        setButtonLoading(btn_basesubmit, false);
    }
}

// 更新密码
async function update_passwd() {
    if (!st_oripasswd.value.trim() || !st_newpasswd.validity.valid || st_newpasswd.value !== st_tnewpasswd.value) {
        snackbarshow('哼，连密码要求都不看！');
        return;
    }
    if (st_newpasswd.value.trim() !== st_tnewpasswd.value.trim()) {
        snackbarshow('哼，两次密码都不一致，你到底有没有认真啊！');
        return;
    }

    setButtonLoading(btn_cpsubmit, true);

    const sendData = { 'oripasswd': hex_md5(st_oripasswd.value.trim()), 'newpasswd': hex_md5(st_newpasswd.value.trim()) };

    try {
        const resp = await fetch('/api/account/updatepasswd', {
            'method': 'POST',
            'headers': { 'Content-Type': 'application/json' },
            'body': JSON.stringify(sendData)
        });

        if (!resp.ok) throw new Error('むむむ...请求失败desu！(。>︿<)_θ 错误代码：'+resp.status+' 的说~');

        const rdata = await resp.json();
        if (rdata.code === 200) {
            snackbarshow(rdata.details);
        } else {
            throw new Error(rdata.details);
        }
    } catch (err) {
        console.error(err.message);
        snackbarshow('Error: ' + err.message);
    } finally {
        setButtonLoading(btn_cpsubmit, false);
    }
}
