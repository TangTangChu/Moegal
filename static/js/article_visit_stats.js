async function stats() {
    const aid = document.querySelector('.article-content').dataset.aid;
    try{
        const formData = new FormData();
	    formData.append('aid', aid);
        const resp = await fetch('/api/stats/articleview',{
            'method':'POST',
            'body':formData
        });
        const rdata = await resp.json();
        console.log(rdata.details);
    }
    catch(err){
        console.log('数据统计失败\n'+err.message)
    }
}

stats();
