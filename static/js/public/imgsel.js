const select_mode = document.getElementById('select_mode');
const imgselector_sel_info = document.getElementById('imgselector-sel-info');
const imgselector_sel_load = document.getElementById('imgselector-sel-load');
const imgselector_view = document.getElementById('imgselector-view');
const select_tg = document.getElementById('select_tg');
const mtarget = document.getElementById('imgselector-mtarget')
import {snackbarshow} from '/static/js/public/snackbarshow.js';
imgselector_sel_load.addEventListener('click', loadimg);
imgselector_view.addEventListener('load', calpix);

function calpix() {
	imgselector_sel_info.innerHTML = `${imgselector_view.naturalWidth} × ${imgselector_view.naturalHeight} px`;
}

async function loadimg() {
	if (select_mode.value == 'sel-target1') {
		getimg(`/uploads/images/${select_tg.value}.webp`);
	} else {
		const formData = new FormData();
		formData.append('iid', select_tg.value);
		await fetch('/api/image/getImgPath', {
				method: 'POST',
				body: formData
			})
			.then(response => response.json())
			.then(result => {
				if(result.code==200){
                    getimg(result.details);
                }
				else{
					throw new Error(result.details);
				}
			})
			.catch(error => {
				snackbarshow(error.message);
				console.error('Error:', error);
			});
	}
}

async function getimg(url) {
    try {
        const response = await fetch(url);
        if (!response.ok) {
            throw new Error('むむむ...请求失败desu！(。>︿<)_θ 错误代码：'+resp.status+' 的说~');
        }
		mtarget.value=url;
        const blob = await response.blob();
        const objectURL = URL.createObjectURL(blob);
        imgselector_view.src = objectURL;
    } catch (error) {
		snackbarshow(error.message);
        console.error(error.message);
    }
}