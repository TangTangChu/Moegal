async function stats() {
    const gid = document.querySelector('.galresc-info').dataset.gid;
    try{
        const formData = new FormData();
	    formData.append('gid', gid);
        const resp = await fetch('/api/stats/galdownloads',{
            'method':'POST',
            'body':formData
        });
        const rdata = await resp.json();
        console.log(rdata.details);
    }
    catch(err){
        console.log('下载量数据统计失败\n'+err.message)
    }
}

document.getElementById('btn_download').addEventListener('click',stats);
