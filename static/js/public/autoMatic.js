let currentIndex = 0;
const slides = document.querySelectorAll('.slide');
const totalSlides = slides.length;
const slideWidth = 1000; // 根据图片宽度设置
const tooltips = document.getElementById('sliderimg_info');
const slideTrack = document.querySelector('.slide-track');
const indicatorsContainer = document.querySelector('.indicators');
const info =['标题:お願いごと、ひとつ\n画师:さくらめい\nUID:594074\nPID:76721863\nhttps://www.pixiv.net/artworks/76721863','标题:Key 20th anniversary\n画师:Mauve\nUID:564736\nPID:77360040\nhttps://www.pixiv.net/artworks/77360040','标题:亚托莉 2022farewell\n画师:Shelter せれ\nUID:35838417\nPID:104105335\nhttps://www.pixiv.net/artworks/104105335','标题:j20\n画师:手绘狼群\nUID:30689588\nPID:91097936\nhttps://www.pixiv.net/artworks/91097936'];


// 创建指示器
for (let i = 0; i < totalSlides; i++) {
	const indicator = document.createElement('div');
	indicator.classList.add('indicator');
	if (i === 0) indicator.classList.add('active');
	indicator.addEventListener('click', () => {
		currentIndex = i;
		updateSlidePosition();
		updateIndicators();
	});
	indicatorsContainer.appendChild(indicator);
}

function updateSlidePosition() {
	slideTrack.style.transform = `translateX(-${currentIndex * slideWidth}px)`;
}

function updateIndicators() {
	document.querySelectorAll('.indicator').forEach((indicator, index) => {
		if (index === currentIndex) {
			indicator.classList.add('active');
		} else {
			indicator.classList.remove('active');
		}
	});
}

function moveSlide(direction) {
	currentIndex += direction;
	if (currentIndex >= totalSlides) {
		currentIndex = 0;
	} else if (currentIndex < 0) {
		currentIndex = totalSlides - 1;
	}
    tooltips.content=info[currentIndex];
	updateSlidePosition();
	updateIndicators();
}

// 自动轮播
let autoSlideInterval = setInterval(() => {
	moveSlide(1);
}, 3500); // 设置轮播间隔为 3.5秒

// 鼠标悬停时停止自动轮播
const slider = document.querySelector('.slider');
slider.addEventListener('mouseenter', () => clearInterval(autoSlideInterval));
slider.addEventListener('mouseleave', () => autoSlideInterval = setInterval(() => moveSlide(1), 2000));

// 初始化轮播位置
updateSlidePosition();