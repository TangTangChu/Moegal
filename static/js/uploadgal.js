import {snackbarshow} from '/static/js/public/snackbarshow.js';

const mtarget = document.getElementById('imgselector-mtarget');
const gal_name_zhsp = document.getElementById('gal_name_zhsp');
const gal_name = document.getElementById('gal_name');
const gal_name_tralias = document.getElementById('gal_name_tralias');
const gal_released = document.getElementById('gal_released');
const gal_developer = document.getElementById('gal_developer');
const gal_abs = document.getElementById('gal_abs');
const gal_tags = document.getElementById('gal_tags');
const gal_displayname = document.getElementById('gal_displayname');
const btn_submit = document.getElementById('sharegal_submit');
const mdraw = document.querySelector('.markdowneditor .EV #rawmarkdown');
const input_galfile = document.getElementById('input_galfile');
const galfile_info = document.getElementById('selected_galfile');
const allowed_ext = ['.zip','.7z','.rar','.gz','.tar','.xz','.bz2','.iso','.dmg','.lzh'];

btn_submit.addEventListener('click',upgal);
input_galfile.addEventListener('change', function (event) {
    const file = event.target.files[0];
    if (file) {
      const fileName = file.name.toLowerCase();
      const isValid = allowed_ext.some(ext => fileName.endsWith(ext));

      if (!isValid) {
        snackbarshow('不支持的文件格式，请重新选择');
        event.target.value = ''; 
        galfile_info.innerHTML=`不支持${file.type}`;
      }
      else{
        galfile_info.innerHTML=`${file.type}<br>文件名:${fileName}<br>文件大小:${(file.size/1048576).toFixed(3)} Mib`;
      }
    }
  });

function vcheck(){
    if(!gal_name.validity.valid||!gal_abs.validity.valid||!gal_released.validity.valid||!gal_developer.validity.valid||!gal_tags.validity.valid||!gal_name_zhsp.validity.valid||!gal_displayname.validity.valid){
        snackbarshow('请确认填写的信息！')
        return false;
    }
    if(mdraw.value.trim()===''){
        snackbarshow('介绍不可为空');
        return false;
    }
    if(mtarget.value.trim()===''){
        snackbarshow('请选择封面');
        return false;
    }
    if(input_galfile.files.length == 0){
        snackbarshow('请选择Gal文件');
        return false;
    }

    return true;
}

async function upgal(){
    if(vcheck()){
        btn_submit.setAttribute('disabled','');
        btn_submit.setAttribute('loading','');
        btn_submit.innerHTML='上传中';
        const sendData={
            'gal_name':gal_name.value,
            'gal_name_zhsp':gal_name_zhsp.value,
            'gal_name_tralias':gal_name_tralias.value,
            'gal_abs':gal_abs.value,
            'gal_released':gal_released.value,
            'gal_dev':gal_developer.value,
            'gal_tags':gal_tags.value,
            'gal_cover':mtarget.value,
            'gal_desc':mdraw.value,
            'gal_displayname':gal_displayname.value
        }
        try{
            const fd = new FormData();
            fd.append('gal',input_galfile.files[0])
            console.log(input_galfile.files[0]);
            fd.append('data',JSON.stringify(sendData));
            console.log(JSON.stringify(sendData));
            const resp = await fetch('/api/upload/gal',{
                method: 'POST',
                body: fd
            });
            if(!resp.ok){
                throw new Error('むむむ...请求失败desu！(。>︿<)_θ 错误代码：'+resp.status+' 的说~');
            }
            const rdata = await resp.json();
            if(rdata.code == 200){
                snackbarshow('提交成功!2s后跳转至资源页');
                btn_submit.setAttribute('icon', 'check--outlined');
                btn_submit.removeAttribute('loading');
                setTimeout(()=>window.location.assign(`/galres/show?gid=${rdata.gid}`),2000)
            }
            else{
                throw new Error(`服务端返回：${rdata.details}`);
            }
        }
        catch(err){
            btn_submit.removeAttribute('disabled');
            btn_submit.removeAttribute('loading');
            btn_submit.innerHTML='上传失败';
            console.log(err);
            snackbarshow(err.message);
        }
    }
}