const mgleft = document.querySelector('.DropNavbar #gotolatest');
const gleft = document.querySelector('.DropNavbar #gotoprev');
const gright = document.querySelector('.DropNavbar #gotonext');
const mgright = document.querySelector('.DropNavbar #gotooldest');
const dropindex = document.querySelector('.DropNavbar #dropindex');
const btn_drop= document.querySelector('.DropNavbar #btn_drop');
const sumpage = Number(document.querySelector('.DropNavbar #sumpage').innerHTML)?Number(document.querySelector('.DropNavbar #sumpage').innerHTML):1;
const mainurl = window.location.pathname;

mgleft.addEventListener('click',gomleft);
gleft.addEventListener('click',goleft);
gright.addEventListener('click',goright);
mgright.addEventListener('click',gomright);
btn_drop.addEventListener('click',drop);

function gomleft(){
    window.location.assign(`${mainurl}?index=1`);
}
function goleft(){
    var nowindex = getQueryVariable('index');
    if(nowindex==1){
        return;
    }
    else{
        window.location.assign(`${mainurl}?index=${nowindex-1}`);
    }
}
function goright(){
    var nowindex = getQueryVariable('index');
    if(nowindex==sumpage){
        return;
    }
    else{
        window.location.assign(`${mainurl}?index=${nowindex+1}`);
    }
}
function gomright(){
    window.location.assign(`${mainurl}?index=${sumpage}`);
}

function drop(){
    var dindex=parseInt(dropindex.value);
    if(dindex<1||dindex>sumpage){
        return;
    }
    window.location.assign(`${mainurl}?index=${dindex}`);
}
function getQueryVariable(variable)
{
    var query = window.location.search.substring(1);
    var vars = query.split('&');
    for (var i=0;i<vars.length;i++) {
        var pair = vars[i].split('=');
        if(pair[0] == variable){return Number(pair[1]);}
    }
    return(1);
}