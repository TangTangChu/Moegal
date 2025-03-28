import {snackbarshow} from '/static/js/public/snackbarshow.js';
import imageCompression from '/static/js/public/browser-image-compression.js';
const btn_sel = document.getElementById('lab-file-upload');
const btn_upl = document.getElementById('upload-card-btnupl');
const imgview = document.getElementById('upload-card-imgview');
const imginfo = document.getElementById('upload-card-imginfo');
const imginput = document.getElementById('input-imgfile');
const info_name = document.getElementById('info_name');
const info_from = document.getElementById('info_from');
const info_author = document.getElementById('info_author');
const info_desc = document.getElementById('info_desc');
const compsize = document.getElementById('compsize');
const upresult_1 = document.getElementById('upresult_1');
const upresult_2 = document.getElementById('upresult_2');
const upresult_3 = document.getElementById('upresult_3');

btn_upl.addEventListener('click', uplimg);

function selimg(fileDom) {
    const file = fileDom.files[0];
    const filesize = (file.size / 1048576).toFixed(3); // MiB诶，不过银行家舍入法
    const filetype = file.type;

    const reader = new FileReader();
    reader.onload = function (e) {
        imgview.src = e.target.result;
        imgview.onload = function () {
            imginfo.innerHTML = `${filetype} ${filesize} MiB\n${imgview.naturalWidth} × ${imgview.naturalHeight} px`;
            info_name.value = file.name.substring(0, file.name.lastIndexOf('.')) || file.name;
        };
    };
    reader.readAsDataURL(file);
}

function vcheck() {
    if (info_name.value.trim() === '') {
        snackbarshow('名称不可为空！');
        return false;
    }
    if (!imginput.files[0]) {
        snackbarshow('未选择图片！');
        return false;
    }
    return true;
}

async function uplimg() {
    btn_upl.setAttribute('disabled', '');
    btn_upl.setAttribute('loading', '');
    

    if (vcheck()) {
        const sfile = imginput.files[0];
        let cmsfile;

        try {
            btn_upl.innerHTML = '编码中';
            const options = { useWebWorker: true, fileType: 'image/webp' };
            cmsfile = await imageCompression(sfile, options);
            const cmsfsize = cmsfile.size / 1048576; // MiB
            compsize.innerHTML = `转换成Webp后的大小: ${cmsfsize.toFixed(3)} MiB，压缩率 ${(cmsfsize / (sfile.size / 1048576) * 100).toFixed(3)}%（越低越好，赞美你的浏览器编码器）`;
        } catch (err) {
            snackbarshow('转换为Webp时出错 ' + err.message);
            resetUploadButton('转换失败');
            return;
        }
        
        const jsdata = {
            'name': info_name.value,
            'from': info_from.value,
            'author': info_author.value,
            'desc': info_desc.value
        };

        try {
            btn_upl.innerHTML = '上传中';
            const fd = new FormData();
            fd.append('image', cmsfile);
            fd.append('data', JSON.stringify(jsdata));
            const resp = await fetch('/api/upload/img', {
                method: 'POST',
                body: fd
            });

            if (!resp.ok) {
                throw new Error('むむむ...请求失败desu！(。>︿<)_θ 错误代码：'+resp.status+' 的说~');
            }

            const rdata = await resp.json();
            if (rdata.code == 200) {
                snackbarshow(rdata.details);
                btn_upl.setAttribute('icon', 'check--outlined');
                upresult_1.value = rdata.iid;
                upresult_2.value = rdata.path;
                upresult_3.value = `![](${rdata.path})`;
                resetUploadButton('上传成功');
                return;
            } else {
                throw new Error(rdata.details);
            }
        } catch (err) {
            snackbarshow(err.message);
            resetUploadButton('上传失败');
        }
    }
    
}

function resetUploadButton(text) {
    btn_upl.removeAttribute('disabled');
    btn_upl.removeAttribute('loading');
    btn_upl.innerHTML = text; 
}


window.selimg = selimg;