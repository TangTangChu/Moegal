/*
 Navicat Premium Dump SQL

 Source Server         : UbuntuSERVER-moegal
 Source Server Type    : MySQL
 Source Server Version : 101108 (10.11.8-MariaDB-0ubuntu0.24.04.1)
 Source Host           : 192.168.244.100:3306
 Source Schema         : MOEGAL

 Target Server Type    : MySQL
 Target Server Version : 101108 (10.11.8-MariaDB-0ubuntu0.24.04.1)
 File Encoding         : 65001

 Date: 29/03/2025 01:38:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ARTICLES
-- ----------------------------
DROP TABLE IF EXISTS `ARTICLES`;
CREATE TABLE `ARTICLES`  (
  `AID` int NOT NULL AUTO_INCREMENT,
  `aUID` int NULL DEFAULT NULL COMMENT '作者UID',
  `aTitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `aCover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '封面',
  `aContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '文章内容(原始Markdown)',
  `aAbstract` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '简介',
  `aLikes` int NULL DEFAULT 0 COMMENT '喜欢',
  `aPageview` int UNSIGNED NULL DEFAULT 0 COMMENT '浏览量',
  `aDateTime` int NULL DEFAULT NULL COMMENT '发布时间(时间戳)',
  `aComments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '评论',
  `aIsReprint` int UNSIGNED NULL DEFAULT 0 COMMENT '是否转载',
  `aLicense` int NOT NULL DEFAULT 0 COMMENT '使用的协议',
  PRIMARY KEY (`AID`, `aLicense`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARTICLES
-- ----------------------------
INSERT INTO `ARTICLES` VALUES (1, 10001, 'TVアニメ『Summer Pockets』2025年4月放送決定！', '/uploads/images/Summer_Pockets_Anime_KV.webp', '## 情报\n由Key社制作的全年龄恋爱冒险游戏《Summer Pockets》衍生动画将于2025年4月开播\n\n\n### CAST\n- 鹰原羽依里：千叶翔也\n- 鸣濑白羽：小原好美\n- 空门苍：高森奈津美\n- 久岛鸥：稗田宁宁\n- 䌷文德斯：岩井映美里\n- 野村美希：一宫朔\n- 水织静久：小山佐保美\n- 加藤羽未：田中爱美\n- 岬镜子：高本惠\n- 鸣濑小鸠：白石稔\n- 稻荷：铃木木乃美\n- 三谷良一：熊谷健太郎\n- 加纳天善：滨田洋平\n\n', '由Key社制作的全年龄恋爱冒险游戏《Summer Pockets》衍生动画将于2025年4月开播', 0, 187, 1738081559, '{\"comments\": [{\"UID\": \"1\", \"time\": 1738935539, \"content\": \"希望不要变成ARTI动画那样\"}]}', 0, 1);
INSERT INTO `ARTICLES` VALUES (3, 1, '本站Markdown编辑预览器说明', '/uploads/images/Markdown编辑预览器.webp', '## 前言\r\n由于技术渣不会整合其他好看的Markdown编辑器，就此写了个简易的编辑预览器，基于`markdown-it`（markdown预览）和`highlightjs`（语法高亮）实现的，本来想用ESM版本的`markdown-it`，结果它居然还import好几个了其他的包，这我瞬间犯懒了（我要实现无外网也能运行），就用了UMD版本的（应该）.\r\n\r\n然后捏，本人也是**临时**学的`js`、`css`、`html`，一开始被ESM、CommonJS、UMD等的搞得不明所以，后面才一步步调整到ESM，实现代码有些混乱，你将就着吧.\r\n\r\n### 已知的问题\r\n- 可能的一次输入2个全角标点符号、光标抖动\r\n\r\n    由于左侧markdown代码栏用了`highlightjs`实时高亮，虽然每次渲染时我会保存光标位置和滚动条位置，但是我不怎么会js，实现地比较烂，会造成以上异常\r\n\r\n- 用不了Tab键\r\n\r\n    忘记加对Tab的判断了，打4个空格代替吧\r\n\r\n- 加载模板不会自动渲染\r\n  \r\n    触发渲染的操作是用户键盘输入，加载模板是直接把innerHTML给替换，触发不了滴\r\n    \r\n- 怎么粘贴不了链接/粘贴的链接自动变标题了\r\n\r\n    我不到啊\r\n    \r\n- 为什么不修？\r\n\r\n    不会\r\n\r\n- 操作不爽\r\n\r\n    用Typora去\r\n\r\n## 使用的主题\r\n不会整合其他好看的主题，就用[Github的Markdown](https://github.com/sindresorhus/github-markdown-css)\r\n\r\n\r\n## 加装的插件\r\n### 表情(markdown-it-emoji.js)\r\n比如:joy:,用两个半角冒号包裹表情名称\r\n\r\n```markdown\r\n:joy:\r\n```\r\n### 语法高亮|markdown-it-highlightjs.js\r\n没啥说的\r\n```python\r\nprint(\'Ciallo~\')\r\n```\r\n### 生成带有标题的图片|markdown-it-image-figures.js\r\n\r\n官方是这么写的\r\n\r\nRender images occurring by itself in a paragraph as `<figure><img ...></figure>`, similar to [pandoc\'s implicit figures](http://pandoc.org/README.html#images).\r\n\r\nThis module is a fork from [markdown-it-implicit-figures](https://github.com/arve0/markdown-it-implicit-figures) in which I wanted to introduce new features and make sure this was up to what the standard is today.\r\n\r\nExample input:\r\n\r\n```\r\ntext with ![](img.png)\r\n\r\n![](fig.png)\r\n\r\nworks with links too:\r\n\r\n[![](fig.png)](page.html)\r\n```\r\n\r\nOutput:\r\n\r\n```\r\n<p>text with <img src=\"img.png\" alt=\"\"></p>\r\n<figure><img src=\"fig.png\" alt=\"\"></figure>\r\n<p>works with links too:</p>\r\n<figure><a href=\"page.html\"><img src=\"fig.png\" alt=\"\"></a></figure>\r\n```\r\n\r\n### 提供任务列表支持|markdown-it-task-list.js\r\n\r\n- [ ] task1\r\n- [x] task2\r\n\r\n``` \r\n- [ ] task1\r\n- [x] task2\r\n```\r\n### 创建块级自定义容器|mdit-plugin-container.js\r\n官方是这么写的\r\n\r\n使用此插件，你可以创建块容器，例如:\r\n\r\n```\r\n::: warning\r\n_here be dragons_\r\n:::\r\n```\r\n\r\n并指定它们应该如何呈现。如果没有定义渲染器，将创建带有容器名称 class 的 `<div>`：\r\n\r\n```\r\n<div class=\"warning\">\r\n  <em>here be dragons</em>\r\n</div>\r\n```\r\n\r\n但我也没见它生效，可能没有css吧\r\n\r\n### 页脚|mdit-plugin-footnote.js\r\n\r\n脚注 1 链接[^first].\r\n\r\n脚注 2 链接[^second].\r\n\r\n行内的脚注^[行内脚注文本] 定义.\r\n\r\n重复的页脚定义[^second].\r\n\r\n[^first]: 脚注 **可以包含特殊标记**\r\n\r\n    也可以由多个段落组成\r\n\r\n[^second]: 脚注文字。\r\n```markdown\r\n脚注 1 链接[^first]。\r\n\r\n脚注 2 链接[^second]。\r\n\r\n行内的脚注^[行内脚注文本] 定义。\r\n\r\n重复的页脚定义[^second]。\r\n<!--下面是脚注-->\r\n[^first]: 脚注 **可以包含特殊标记**\r\n\r\n    也可以由多个段落组成\r\n\r\n[^second]: 脚注文字。\r\n```\r\n有个问题哈，编辑预览器所处的页面设置了`<base href=\"/\">`来预防一些其他问题，会导致脚注指向的链接是主页.但是在文章页没有设置`<base href=\"/\">`，所以还是可以正常用滴.\r\n\r\n### 提供 \\<ruby\\> 声明支持|mdit-plugin-ruby.js\r\n{中国:zhōng|guó}、{栗山未来:くりやまみらい}、{香風:か|ふう}{智乃:ち|の}\r\n\r\n```markdown\r\n{中国:zhōng|guó}、{栗山未来:くりやまみらい}、{香風:か|ふう}{智乃:ち|の}\r\n```\r\n\r\n', '由于技术渣不会整合其他好看的Markdown编辑器，就此写了个简易的编辑预览器，基于`markdown\n然后捏，本人也是临时学的`js`、`css`、`html`，一开始被ESM、CommonJS、UMD等的搞得不明所以，后面才一步步调整到ESM，实现代码有些混乱，你将就着吧\n    由于左侧markdown代码栏用了`highlightjs`实时高亮，虽然每次渲染时我会保存光标位置和滚动条位置，但是我不怎么会js，实现地比较烂，会造成以上异常\n    忘记加对Tab的判断了，打4个空格代替吧\n    触发渲染的操作是用户键盘输入，加载模板是直接把innerHTML给替换，触发不了滴\n    我不到啊\n    不会\n    用Typora去\n不会整合其他好看的主题，就用[Github的Markdown]([sindresorhus/github\n### 表情(markdown\n比如:joy:,用两个半角冒号包裹表情名称\n```markdown\n:joy:\n```\n没啥说的\n```python\nprint(\'Ciallo~\')\n```\n官方是这么写的\nRender images occurring by itself in a paragraph as `<figure><img ...></figure>`, similar to [pandoc\'s implicit figures](http://pandoc.org/README.html#images).\nThis module is a fork from [markdown\nExample input:\n```\ntext with ![](img.png)\n![](fig.png)\nworks with links too:\n[![](fig.png)](page.html)\n```\nOutput:\n```\n<p>text with <img src=\"img.png\" alt=\"\"></p>\n<figure><img src=\"fig.png\" alt=\"\"></figure>\n<p>works with links too:</p>\n<figure><a href=\"page.html\"><img src=\"fig.png\" alt=\"\"></a></figure>\n```\n``` \n```\n官方是这么写的\n使用此插件，你可以创建块容器，例如:\n```\n::: warning\n_here be dragons_\n:::\n```\n并指定它们应该如何呈现。如果没有定义渲染器，将创建带有容器名称 class 的 `<div>`：\n```\n<div class=\"warning\">\n  <em>here be dragons</em>\n</div>\n```\n但我也没见它生效，可能没有css吧\n脚注 1 链接[^first]。\n脚注 2 链接[^second]。\n行内的脚注^[行内脚注文本] 定义。\n重复的页脚定义[^second]。\n[^first]: 脚注 可以包含特殊标记\n    也可以由多个段落组成\n[^second]: 脚注文字。\n嘻嘻，有bug，会跳转到首页，可能是我在head设置了`<base href=\"/\">`\n{中国:zhōng|guó}、{栗山未来:くりやまみらい}、{香風:か|ふう}{智乃:ち|の}\n```markdown\n{中国:zhōng|guó}、{栗山未来:くりやまみらい}、{香風:か|ふう}{智乃:ち|の}\n```', 0, 33, 1739067656, '{\"comments\": [{\"UID\": \"10001\", \"time\": 1739152201, \"content\": \"2333333\"}, {\"UID\": \"1\", \"time\": 1739168850, \"content\": \"突然感觉介绍这种东西还是MediaWiki好用\"}]}', 0, 1);

-- ----------------------------
-- Table structure for GALRES
-- ----------------------------
DROP TABLE IF EXISTS `GALRES`;
CREATE TABLE `GALRES`  (
  `GID` int NOT NULL AUTO_INCREMENT COMMENT 'GalResource ID',
  `gName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '原始名称',
  `gDeveloper` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '开发商',
  `gReleased` date NULL DEFAULT NULL COMMENT '发行时间',
  `gTranslation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '翻译',
  `gTranslationsAliases` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '其他翻译名称',
  `gAbstract` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '简介',
  `gDesc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '介绍',
  `gCover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '封面',
  `gUploadTime` int NULL DEFAULT NULL,
  `gTag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '标签',
  `gUID` int NOT NULL,
  `gReslink` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '资源链接',
  `gDownloads` int UNSIGNED NULL DEFAULT 0 COMMENT '下载量',
  `gDisplayName` int NULL DEFAULT 1 COMMENT '指定展示时的名字',
  PRIMARY KEY (`GID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of GALRES
-- ----------------------------
INSERT INTO `GALRES` VALUES (5, 'ハミダシクリエイティブ', 'Madosoft', '2020-09-15', '常轨脱离Creative', '灵感满溢的甜蜜创想、富婆妹', '以“不上学”×“Creative”为主题，一如既往的Madosoft风格。与脱离常轨的女孩子们轰轰烈烈地来一场不寻常的恋爱吧！', '## 概述\n\n**季节流转，时间为6月末。**\n\n公认的自闭男：**和泉智宏**本以为今天能如同往常一样蜷在角落里度过安稳的一日，然而事与愿违。\n\n\n\n**“恭喜恭喜恭恭喜！**\n\n**总之这届学生会长就决定是你了**\n\n**和泉童鞋——！”**\n\n\n\n校方突发奇想，搞起了抽签，抓到阄的人就要当选学生会长。\n\n而那个抽中上上签的天选之子，便是智宏！\n\n\n\n抽中签的智宏在顾问的要求下，踏上了寻找伙伴的旅途。\n\n然而顾问的名单中，赫然写着的名字：\n\n同班同学华乃，后辈明日海，就连妹妹妃爱，都是不上学的问题儿童？！\n\n混乱之中，就连一直毫无音信的前学生会长诗樱都突然现身？！\n\n\n\n——是上天注定，还是命运使然？ 前所未闻而又空前绝后的， 《抓阄学生会长》的战争， 即将开始……！\n\n## STAFF\n\n- 监督：もじゃすびい\n- 美术：宇都宮つみれ、茜屋\n- 音乐：まつむー\n- 剧本：甲木順之助\n\n## CAST\n\n### 主角\n- 和泉智宏（和泉 智宏（いずみ ともひろ））\n	\n	本作的主角。\n	\n- 和泉妃爱（和泉 妃愛（いずみ ひより））\n	\n	智宏的妹妹。童星出身，以“小泉妃爱”名义活动的声优。靠着声优收入及家事技巧照顾哥哥。学生会副会长。\n	\n- 常盘华乃（常盤 華乃（ときわ かの））\n	\n	转学生。和泉智宏国中同学。从转学第二天起直到智宏上门拜访前一直出于旷课状态。新任学生会长和泉智宏第一个招募加入学生会的成员。以“乃乃花”名义活动的插画家。从事社交游戏等工作。常在Comic Market贩卖同人志。喜欢章鱼烧。镰仓诗樱所写小说粉丝。\n	\n- 锦明日海（錦 あすみ（にしき あすみ））\n	\n	出身音乐世家。智宏的学妹。成为Vtuber前为使用VOCALOID软件制作歌曲并在网站投稿的音乐人。以常盘华乃设计的虚拟人物“雪景式”名义进行Vtuber活动。有着不亚于专业歌手的歌唱能力。新任学生会长和泉智宏最后一个招募加入学生会的成员，担任“书记官”的职务。喜欢肉包子。\n	\n- 镰仓诗樱（鎌倉 詩桜（かまくら しお））\n	\n	前学生会长。“会长抽签事件”其实正是因为她辞退整个学生会又在学期中丢下学生会工作而造成的。经常协助及参加学生会的大部分活动。以“星紫苑”名义活动的职业作家。将自己的生活经验活用于描写中。和泉妃爱粉丝。\n	\n### 其他\n\n- 龙闲天梨\n- 和泉里\n- 新川广梦\n- 圣莉莉子\n\n## 主题曲\n**OP《Unreal Creation!》**\n\n歌：樱川惠，作词：stel，作曲、编曲：堀江晶太)\n\n> 部分内容来自维基百科，通过[署名—相同方式共享 4.0 协议国际版](https://creativecommons.org/licenses/by-sa/4.0/deed.zh-hans)引用', '/uploads/images/常轨脱离Creative.webp', 1738730625, '校园|恋爱', 1, '/uploads/galres/04706bc6a184524aa599493664af85af.zip', 4, 1);
INSERT INTO `GALRES` VALUES (6, 'Summer Pockets', 'Key', '2018-06-29', '夏日口袋', '', '「唯有那片炫目，始终未曾忘却。」 由创作出「CLANNAD」等名作的游戏品牌Key带来的一款文字冒险游戏。 「暑假」「与伙伴的盛夏回忆」「乡愁」 在远离尘嚣的小岛上，与伙伴共度夏日的时光，谈场盛夏的恋爱。 这是夏日的故事。 无法忘怀，也不能忘怀的夏日回忆。', '# 如果您愿意的话，让我带您去吧，这座小镇，愿望实现的地方……\r\n\r\n《Summer Pockets》（日语：サマーポケッツ，日语简称：サマポケ，中文名：夏日口袋）是由Key（“Key社”）制作的一部全年龄恋爱冒险游戏作品\r\n\r\n## 概述\r\n主人公鹰原羽依里为了整理过世祖母的遗物，\r\n利用暑假独自一人来到鸟白岛。\r\n\r\n走下一天只有几趟的联络船的时候，他与一名少女相遇。\r\n她任海风吹拂着发丝，只是一直眺望着那条说不出是海是空的界线，渐行渐远……\r\n恍然回神，那少女已不知走到哪里了。羽依里的心像是被狐狸揪了一下似的，但他依旧向祖母家走去。\r\n\r\n那里住了名亲戚——姑妈，她正在整理遗物。\r\n羽依里在帮忙整理祖母的回忆之物时，\r\n虽然对于初次接触的「岛上生活」感到困惑，却也逐渐适应着这样的生活。\r\n\r\n都市生活里是没法感受到与大自然的亲密接触的。\r\n这样的岛上生活让他想起了不知从什么时候起便已遗忘的记忆。\r\n\r\n与眺望大海的少女相遇，\r\n与寻找不可思议蝴蝶的少女相遇，\r\n与寻找回忆与海盗船的少女相遇，\r\n与住在宁静灯塔中的少女相遇，\r\n\r\n在岛上结识了新的伙伴——\r\n\r\n\r\n当时的他想，如果这个暑假永远都不结束就好了。\r\n\r\n\r\n## STAFF\r\n\r\n- 原案：麻枝准\r\n- 制作人：丘野塔也\r\n- 监督：魁\r\n- 原画：Na-Ga、和泉つばす、永山ゆうのん、ふむゆん、えんぎよし(SD)\r\n- 剧本：新岛夕、魁、ハサマ\r\n- 音乐：折户伸治、麻枝准、どんまる、竹下智博、水月陵\r\n\r\n## CAST\r\n- 鹰原羽依里（鷹原 羽依里，Takahara Hairi）\r\n	\r\n    本作品的男主角。因为有不愉快的经历，于是在为过世的奶奶整理遗物时，而来到鸟白岛。在高中本来隶属于游泳部，因为某些缘由从而远离游泳。此后，成为不良学生卷进暴力事件，最后受到停学处罚。鸟白岛上住民如同对待旧友一般欢迎着从家里出来的羽依里。\r\n	\r\n- 鸣濑白羽（鳴瀬 しろは，Naruse Shiroha）\r\n\r\n  本作的剧情核心女角色，喜欢西瓜冰棒。出身于鸟白岛上主导海之祭祀的鸣濑家系，由于她的家系所持有的特殊能力，使得岛上的一些人都用特别的眼光看待她，外加白羽自身也觉察到了这份能力的危险性，自己主动选择远离岛上的住民，变成了“孤身一人”。在白羽线中，同羽依里等人度过一个美好的暑假后，也成长为了一个亭亭玉立的少女。\r\n\r\n- 空门苍（空門 蒼，Sorakado Ao）\r\n\r\n  继承岛之传承的少女，出身于主管山之祭祀的空门家系，通过触摸七影蝶，获得他人的记忆，从而能够保有相当庞大的知识量。然而，作为代价，需要通过大脑整理记忆，因此不得不与睡意相抗衡。苍之所以选择触犯禁忌，则是为了寻找到，在幼年时为了帮助自己，从而遭遇事故并因此陷入昏迷的双胞胎姐姐的记忆。因为获得了大量的记忆，所以也就熟知男女之事，经常有听错而满嘴开火车的情况发生，故而同伴们也认为她是闷骚粉脑袋。在苍线中的最后，她在同羽依里度过的这个夏天当中，也成功蜕变，成为了成熟的女性。\r\n\r\n- 久岛鸥（久島 鴎，Kushima Kamome）\r\n\r\n  为了实现在儿时和伙伴的约定，从而来到鸟白岛的少女。她的目的，就是为了寻找到在藏宝图显现的小岛的秘密——海盗船。她总是拉着行李箱，却并不曾告诉别人里面到底是什么东西，而在与羽依里寻找宝藏的尾声，向羽依里说出“这里面就是真正的我”。在欧线中，为了实现鸥的“真正的愿望”，羽依里将剩余的所有暑假，都献给了她。\r\n\r\n- 䌷 文德斯（紬 ヴェンダース，Tsumugi Wenders）\r\n\r\n  居住在岛上废弃灯塔的不可思议少女，口头禅是“姆啾”。德日混血，为了在暑假中找到“想做的事情”而从“大洋彼岸”来到这里。䌷本人是知道自己真正的身份的，所以每当她和羽依里愈发亲近，她就越为“暑假结束后不得不回到朋友身边”而难过。在䌷线中，温柔的羽依里和静久在接纳这样的䌷之后，帮助她度过了整整一生的快乐时光，直到那最后一刻。䌷 文德斯（少女）（ツムギ·ヴェンダース，Tsumugi Wenders）遭遇神隐，从而长时间地被困在灯塔里的少女。她就是玩偶熊“䌷”所寻找的“自身”，也是䌷（玩偶熊）最重要的朋友。\r\n\r\n### 其他\r\n\r\n- 加纳天善\r\n\r\n  将青春过度奉献给乒乓球的男人。也是岛上的住民，同三谷良一同年级，还是儿时伙伴。外表上看起来冷静知性，实际上却因为太沉迷于乒乓球了，所以无论言行，都必然离不开乒乓球的角色。将乒乓球桌带进岛内的秘密基地，每天都在做奇怪的特训。家里是经营修理业的，所以他也会修理羽依里的摩托，并且时不时展现出设计意识很强的一面。\r\n- 三谷良一\r\n\r\n  爱好脱衣服的人。他是鸟白岛的住民，同羽依里同年级。过去本来是很弱气的，通过白羽线某件事情，成长为现在这个阳光开朗的性格。虽然他是喜爱脱衣服的人，不过因为他是敏感性皮肤，所以很怕盐水。经常被守护小岛治安的野美希狙击。虽然他有一个摩托艇，不过骑上去会变得全身湿透，他还将岛内某处废弃小屋改造成了秘密基地，经常泡在那里。\r\n\r\n- 岬镜子\r\n\r\n  守望着暑假的女性。羽依里的母亲的妹妹，也就是羽衣里的阿姨，有着与年龄不相符的外貌。沉迷考古学，因为古物收集，同加藤奶奶有些联系。她就是通过整理遗物的理由而将羽依里叫到岛上的人。她做饭的手艺不仅致命，而且独特，甚至可以让羽未颤抖。她与白羽的母亲瞳同学年，也是老朋友了。她处在一个俯瞰的视角，引导著羽未和羽依里。\r\n\r\n- 稻荷\r\n\r\n  栖息在鸟白岛上的狐狸，雌性。\r\n\r\n- 鸣濑小鸠\r\n\r\n  鸟白岛上的健壮老翁。白羽的外公。自从自己的女儿女婿离开后，一个人将外孙女养大。很关心在岛内被孤立的白羽，对试图靠近白羽的人毫不留情。本人则是鸟白岛上传承的“水中格斗技”的熟练者，为了白羽而和羽依里对决。相貌严肃，不善言语，但对白羽的爱非常深。在“公主”沉睡后接替“公主”担当“岛可梦对战之王”的称号，钻研和磨练自己十年也从未赢过“公主”。\r\n\r\n- 空门蓝\r\n\r\n  苍的双胞胎姐姐。年少时在寻找苍所说的蝴蝶时发生意外，至今住院，昏迷不醒。岛可梦战士排行榜中隐藏着的真正第一，被岛可梦战士们称为“公主”，“岛可梦对战之王”的称号在当时无人能撼动。\r\n\r\n- 久岛鹭\r\n\r\n  鸥的母亲。\r\n\r\n## 相关音乐\r\n\r\n### OP\r\n\r\n- **《アルカテイル》**\r\n\r\n	作词：魁 ／ 作曲：折户伸治 ／ 编曲：中山真斗 ／ 演唱：铃木木乃美\r\n\r\n### ED \r\n- **《Lasting Moment》**\r\n\r\n	作词：新岛夕 ／ 作曲：どんまる ／ 编曲：どんまる ／ 演唱：铃木木乃美\r\n\r\n> 部分内容来自维基百科，通过[署名—相同方式共享 4.0 协议国际版](https://creativecommons.org/licenses/by-sa/4.0/deed.zh-hans)引用\r\n>\r\n> 部分内容来自[萌娘百科](https://mzh.moegirl.org.cn/Summer_Pockets)，通过[署名-非商业性使用-相同方式共享 3.0中国大陆](https://creativecommons.org/licenses/by-nc-sa/3.0/cn/)引用', '/uploads/images/SummerPockets.webp', 1739086662, '恋爱|冒险', 1, '/uploads/galres/f1a63f0cc9fa63f6f7381630b50d5dc8.zip', 1, 2);
INSERT INTO `GALRES` VALUES (7, 'CLANNAD', 'Key', '2004-04-28', '团子大家族', '光守望的坡道、家族', '空前热门的作品「CLANNAD」通过「家族」这一主题，以宏大的剧本、美丽的CG和动人的音乐，描绘了一个人与小镇、人与人的故事。', '# 如果您愿意的话，让我带您去吧，这座小镇，愿望实现的地方……\n\n一段长长的坂道，一段人生的旅程；\n一个个家族，和孕育他们的小镇的故事；\n一段冬日的……幻想物语。\n\n## 概述\n\n在某个小镇，主角冈崎朋也因为家庭的因素而丧失了生活在这个地方的希望；与春原阳平为朋友，在光坂高等学校过着潦倒的生活，盼望终有一天能够离开所在的小镇，还有马桶盖子。在高三的一个早晨，通往学校的坡道前发现了一个止步不前的女孩，在朋也认识了这个名为古河渚的女孩后，他的生活开始有了重大的变化……\n\n## STAFF\n\n- 企画：麻枝准\n- 脚本：麻枝准、凉元悠一、魁\n- 原画：樋上至\n- 音乐：折户伸治、戸越まごめ、麻枝准\n\n## CAST\n\n- 冈崎朋也：伊藤健太郎（PS2版）\n- 古河渚：中原麻衣\n- 冈崎汐：兴梠里美\n- 古河秋生：置鲇龙太郎\n- 古河早苗：井上喜久子\n- 藤林杏：广桥凉\n- 藤林椋：神田朱未\n- 一之濑琴美：能登麻美子\n- 坂上智代：桑岛法子\n- 伊吹风子：野中蓝\n- 春原阳平：阪口大助\n- 相乐美佐枝：雪野五月\n- 宫泽有纪宁：榎本温子\n- 牡丹：川名真知子\n- 志麻贺津纪：朴璐美\n- 幸村俊夫：青野武\n- 春原芽衣：田村由香里\n- 芳野祐介：绿川光\n- 伊吹公子：皆口裕子\n- 冈崎直幸：中博史\n- 冈崎史乃：麻生美代子\n- 仁科理惠：相泽舞\n- 柊胜平：白石凉子\n\n\n## 相关乐曲\n\n### OP\n- **《メグメル》**\n\n    作词：riya ／ 作曲：eufonius ／ 编曲：kiku ／ 演唱：riya\n### ED\n- **《－影二つ－》**\n\n	作词：魁／ 作曲：戸越まごめ ／ 编曲：戸越まごめ ／ 演唱：riya\n\n> 部分内容来自[萌娘百科](https://mzh.moegirl.org.cn/CLANNAD)，通过[署名-非商业性使用-相同方式共享 3.0中国大陆](https://creativecommons.org/licenses/by-nc-sa/3.0/cn/)引用', '/uploads/images/CLANNAD.webp', 1739108477, '治愈|致郁|催泪', 10003, '/uploads/galres/9be6e06dcd1737b2da244a3499e548eb.zip', 0, 2);
INSERT INTO `GALRES` VALUES (8, 'planetarian ～ちいさなほしのゆめ～', 'Key', '2004-11-29', '星之梦', '', '因宇宙开拓的失败而导致的世界大战，已经过去了五十余年。 绝大部分的人类都已消亡，地表不停地下着雨。 名为 “废墟猎人” 的男人，在这座时间本应停滞的封印都市之中， 遇见了一台形如纯洁少女般的机器人。 “请不要将天堂…分开”', '# 请不要将天堂…分开\n## 概述\n无穷无尽的雨————\n\n30年前，因为突如其来的细菌袭击\n\n而被遗弃的 “封印都市”\n\n现在已经沦为被自律型战斗机械所支配的\n\n无人的废墟\n\n而他，来到了这里\n\n筋疲力尽的他所藏身的大楼之中\n\n有着一座星象馆\n\n那是很久以前，人们仰望漫天繁星\n\n治愈心灵的空间\n\n在那里，他遇见了一位少女\n\n少女名为 “梦美”\n\n是这座星象馆的解说员\n\n30年间，她一直等候着客人的来访\n\n而她，是一台快要坏掉的机器人————\n\n一如 “梦美” 的祈求\n\n为了让动弹不得的投影仪再次启动\n\n他没日没夜地埋头修理着\n\n下个不停的雨\n\n伴随着“梦美” 和他静静流逝的时间\n\n犹如悠远乡愁般的每一天，动摇着他的内心\n\n身处人造的星空之下，他又在想些什么？\n\n而“梦美”的命运，又将何去何从——？\n\n“请不要将天堂…分开”\n## STAFF\n- 企画·剧本：凉元悠一\n- 原画·机械设定：驹都英二\n- 音乐：户越まごめ\n\n## CAST\n- 废墟猎人：小野大辅\n- 星野梦美：铃木惠子\n- 馆长：石上祐一\n- 老废墟猎人：千千和龙策\n\n## 相关音乐\n### OP\n- **《星の世界》**\n\n	作曲：查尔斯·C·康弗斯 \\ 编曲：户越まごめ\n\n### ED\n- **《星めぐりの歌》**\n\n	作词·作曲：宫泽贤治 \\ 编曲：户越まごめ \\ 歌：MELL\n\n\n\n> 部分内容来自[萌娘百科](https://mzh.moegirl.org.cn/星之梦(游戏)#)，通过[署名-非商业性使用-相同方式共享 3.0中国大陆](https://creativecommons.org/licenses/by-nc-sa/3.0/cn/)引用', '/uploads/images/星之梦.webp', 1739114457, '奇幻|治愈|致郁|催泪', 10003, '/uploads/galres/dca2d5e9a28b0ad7a877aac931578f23.zip', 1, 1);
INSERT INTO `GALRES` VALUES (9, '恋×シンアイ彼女', 'Us:track', '2015-10-30', '想要传达给你给你的爱恋', '传达不到的爱恋', '《想要传达给你的爱恋》是日本美少女游戏知名大厂AMUSE CRAFT旗下品牌Us:track制作的恋爱题材大作。人气原画师君岛青、仓泽磨子与白玉联袂为本作担当原画与角色设计，由知名话题剧本家新岛夕领衔编写剧本，并由业内资深音乐人水月陵制作音乐。本作各女主角也均由业内知名声优出演。', '## 概述\r\n\r\n## STAFF\r\n\r\n- 企画、原案：志水マサトシ\r\n- 编剧：新岛夕、真崎ジーノ、茶渡エイジ、条智凉介\r\n- 角色设计、原画：きみしま青、しらたま、倉澤もこ、ぺろ\r\n- SD原画：あまからするめ\r\n- 音乐：水月陵\r\n- OP制作：Mju:z\r\n\r\n## CAST\r\n\r\n### 主要人物\r\n\r\n- 姬野星奏：阿部朔\r\n\r\n	这个略湿呆板而娇着可爱、**容易攻略**的女生，**总是陪伴在身边**\r\n- 新堂彩音：遥空\r\n\r\n	再次见面时，这个傲娇叉清纯的女生依旧是气鼓鼓的样子\r\n- 小鞠结衣：远野梵\r\n\r\n	这个娇小温柔的女生，已经爱慕主人公到了无法自已的地步\r\n- 四条凛香：日伞世玲那\r\n\r\n	这个受全校学生仰慕的女生外表高冷内心娇羞，同时叉喜爱调侃人\r\n\r\n### 次要人物\r\n\r\n- 国见菜子\r\n- 樱田志乃\r\n- 贵志凉介\r\n- 爱美姐\r\n- 如月奈津子\r\n- 森野精华\r\n- 映画研究会部长：金田马夫\r\n\r\n\r\n## 相关音乐\r\n### OP\r\n- **記憶×ハジマリ**\r\n\r\n	词：Duca \\ 曲：宫崎京一 \\ 歌：Duca\r\n### ED\r\n- **東の空から始まる世界**\r\n\r\n	词：yuiko \\ 曲：Meis Clauson \\ 歌：yuiko\r\n### IN\r\n- **GLORIOUS DAYS**\r\n\r\n	词：yuiko \\ 曲：Meis Clauson \\ 歌：yuiko\r\n\r\n> 部分内容来自[萌娘百科](https://mzh.moegirl.org.cn/想要传达给你的爱恋)，通过[署名-非商业性使用-相同方式共享 3.0中国大陆](https://creativecommons.org/licenses/by-nc-sa/3.0/cn/)引用', '/uploads/images/想要传达给你的爱恋.webp', 1739115939, '恋爱|学院', 10001, '/uploads/galres/39502112ff6fd2bdfbf23d2a63e6d007.zip', 0, 1);
INSERT INTO `GALRES` VALUES (10, '千恋＊万花', 'YUZU SOFT', '2016-07-29', '千恋＊万花', '', '《千恋＊万花》是日本美少女游戏品牌Yuzusoft（柚子社）2016年制作的一款和风恋爱题材作品。本作发售后展现出了势如破竹的高人气，并获得萌系游戏大赏的年度准大奖以及Getchu美少女游戏大赏中获得综合类排名第一的殊荣，在剧本、系统、图像、音乐、影片、角色等多个奖项中也均有斩获。', '## 概述\r\n\r\n![](/uploads/images/千恋＊万花_story_1.webp)\r\n\r\n## STAFF\r\n- 角色设计、原画：梦璃凛、小舞一 、煎路[5]\r\n- SD原画：菰绵遥华\r\n- 剧本：天宮りつ、藤太、濑尾顺\r\n- 音乐：Famishin、Angel Note\r\n- CG：モドキさん、トミフミ、煎路、ぼってぃー（事务）\r\n\r\n## 相关音乐\r\n### 片头曲(OP)\r\n- 以恋结缘 （恋ひ恋ふ縁）\r\n\r\n	演唱：KOTOKO\r\n\r\n    编曲：井之原智，作曲：Famishin，作词：KOTOKO\r\n\r\n	吉他：Asai Yasuo，三味线：尾上秀树\r\n### 片尾曲(ED)\r\n- 芳乃线：爱与感谢 （愛しさと感謝の気持ち）\r\n\r\n	演唱：榊原由依\r\n\r\n	编曲：井之原智，作曲：Famishin，作词：中山♡マミ（Angel Note）\r\n\r\n	吉他：Asai Yasuo\r\n- 茉子线：与子偕老 （ふたりで）\r\n\r\n	演唱：Riryka\r\n\r\n	编曲：R.East，作曲：Famishin，作词：kala\r\n- 丛雨线：形影成双 （ふたつの影）\r\n\r\n	演唱：春風まゆき\r\n\r\n	编曲：森まもる，作曲：Famishin，作词：春風まゆき\r\n\r\n	吉他：Asai Yasuo\r\n- 蕾娜线：GIFT\r\n\r\n	演唱：カサンドラ\r\n\r\n	编曲：新井健史，作曲：Famishinn，作词：カサンドラ\r\n\r\n	吉他：エキセントリック山田太郎，原声吉他、电子琴：新井健史\r\n- 小春线：Love flower\r\n\r\n	演唱：叶月\r\n\r\n	编曲：椎名俊介，作曲：Famishin，作词：叶月\r\n\r\n	吉他：椎名俊介\r\n- 芦花线：伴你身旁 （キミのとなり）\r\n\r\n	演唱：TOHKO\r\n\r\n	编曲：森まもる，作曲：Famishin，作词：TOHKO\r\n\r\n	吉他：Asai Yasuo\r\n\r\n> 部分内容来自[萌娘百科](https://mzh.moegirl.org.cn/%E5%8D%83%E6%81%8B%E4%B8%87%E8%8A%B1)，通过[署名-非商业性使用-相同方式共享 3.0中国大陆](https://creativecommons.org/licenses/by-nc-sa/3.0/cn/)引用\r\n', '/uploads/images/千恋＊万花.webp', 1739154633, '恋爱|喜剧', 10001, '/uploads/galres/eda3f3c78c6b1d5518a67296696f3d87.zip', 0, 1);
INSERT INTO `GALRES` VALUES (11, 'ATRI -My Dear Moments-', 'ANIPLEX.EXE、Frontwing、枕社(The pillow)', '2020-06-19', '亚托莉 -我挚爱的时光-', '', '「在日渐沉没的世界里，我找到了你。」在不远的未来，海平面原因不明地急速上升，导致了地表多数都沉入海中。在一个逐渐沉入海中的平和小镇，属于少年和机器人少女的难忘夏日就这么开始了——', '# 在日渐沉没的世界里，我找到了你.当我和你相遇，停滞的时间再次开始了流动\n\n## 概述\n\n这颗星球正在沉没——\n海平面因不明原因急速上升，海洋吞没了大部分沿海地区，如今也在不断蚕食着陆地。\n人类的栖息地被迫收缩，处于巅峰时期的科学技术不断流失。\n这是逐渐迈向灭亡的平静时代。\n\n## STAFF\n\n总监：SCA-自\n\n剧本：紺野アスタ\n\n角色：ゆさの、基4\n\n音乐：松本文紀\n\n美术：わいっしゅ(背景)、田口まこと(SD原画)\n\n## CAST\n\n### 主要角色\n- 斑鸠夏生（斑鳩 夏生）　声优：小野贤章（仅电视动画）\n	\n	本作主角，因一次意外丧母，同时失去右腿而需依靠义肢行走。他就读科学院，但因自身原因休学回到祖母曾生活的地方。他最终回到科学院继续学习，并利用海上浮岛解决了人类生存问题，在和青梅竹马水菜萌结婚60年后进入虚拟世界与亚托莉度过最后一天。\n- 亚托莉（アトリ）　声优：赤尾光\n	\n	本作的女主角，是一个拥有自我感情的机器人，被称为技术奇点。她原本是属于夏生母亲的机器人，在为夏生的母亲出恶气致人受伤后只得隐蔽起来。夏生的母亲在意外发生后弥留之际将她转继给夏生，亚托莉之后被封存。在被主人公打捞后，她在与主人公的共同生活中培养出了亲密关系。她一度利用日志本欺骗主人公自己没有真正的情感，但最后还是完全流露。她被安排为人工浮岛的控制系统，并在游戏最后意识融入其中，在60年间等待主人公的意识来到虚拟世界中。\n### 其他角色\n- 神白水菜萌（神白 水菜萌）　声优：高桥未奈美\n	\n	主人公夏生的儿时玩伴，经常照顾主人公。亚托莉私下将夏生托付给她，希望在自己进入浮岛系统后陪伴主人公。在之后她与夏生结婚共度60年的时光，但内心也一直牵挂着亚托莉。\n- 野岛龙司（野島 竜司）　声优：细谷佳正\n	\n	当地的青年。性格正直。肌肉发达体格很壮，是那种比起动脑更擅长运动的类型。像是本地孩子们老大般的存在。后成为浮体都市诺亚的第一任市长。\n- 凯瑟琳（キャサリン）　声优：日笠阳子\n\n	本名为“小佐田花子（おさだ はなこ）”。夏生祖母的债权人，追着夏生讨债。实际上她是当地先前失踪的一位少女，回到故乡后她担任了当地学校的教师，也放弃了讨债。如果只是笑着不说话，还算是个充满神秘感的美女。\n- 名波凛凛花（名波 凜々花）　声优：春野杏\n\n	在当地学校就读的一位好学女孩。她之后也考入科学院就读。成为能源技术专家。\n	\n> 部分内容来自[萌娘百科](https://mzh.moegirl.org.cn/ATRI_-My_Dear_Moments-)，通过[署名-非商业性使用-相同方式共享 3.0中国大陆](https://creativecommons.org/licenses/by-nc-sa/3.0/cn/)引用\n> \n> 部分内容来自维基百科，通过[署名—相同方式共享 4.0 协议国际版](https://creativecommons.org/licenses/by-sa/4.0/deed.zh-hans)引用', '/uploads/images/ATRI-My_Dear_Moments.webp', 1739163478, '末日|催泪|治愈', 10001, '/uploads/galres/9ce6e63d07b6d254b84e8f161fd36ce4.zip', 2, 2);
INSERT INTO `GALRES` VALUES (12, 'eden*', 'minori', '2009-09-18', '伊甸园', '', '这是在一个即将毁灭的星球上发生的最后爱情故事。 在不久前，天空中突然出现了一颗红色灾星。它的存在即将导致地球上所有生命的灭绝。统一政府提出了将全人类带入太空的逃离计划。为了使看似不可能的计划成为现实，“菲利克斯”被带到了这个世界。基因改造后的菲利克斯拥有超人的能力，不老不死，智慧超群，是人类生存的唯一希望。', '# 晚安\n\n——Eden\\* They were only two,on the planet\n\n——那是地球最后的恋爱故事。\n\n遥远未来的故事。\n\n![](/uploads/images/Eden_剧照.webp)\n## 概述\n在地球遥远的未来，由于火星附近出现巨大的能量体，使地球发生了各种变异，引发全球性的战争和恐怖主义，地球在毁灭性的打击下离灭亡只剩下100年。\n\n为了赶在100年内离开地球，人类制定“地球脱出计划”。为了实现这个计划，建立“地球统一政府”以打压异己和集中一切可利用资源；另一方面，为了解决人类智慧和肉体的局限性以保证计划的延续性，又制定“地球脱出计划”的核心“Felix计划”——通过基因改造，获得高智能的长生不老的生命体，即“Felix”。本作的女主角紫苑（一作sion）（シオン）即为其中一名Felix。\n\n第99年，撤出行动完全结束后，原特殊部队成员榛名亮被派往第703研究所，与紫苑邂逅。而亮的任务就是守护这个为“地球脱出计划”奉献一生的少女，以及限制她的自由。后来在地球毁灭的最后时间里守护她前往死亡的乐园…\n## STAFF\n\n- 企画：酒井伸和\n- 原作、脚本：镜游\n- 人物设定、作画监督：ちこたむ、KIMちー\n- 监督：御影\n- 动画制作：sata、tsukune.、结城辰也\n- 特别鸣谢：新海诚\n\n## CAST\n※声优名顺序：游戏本编 / PLUS+MOSAIC\n\n### 主要登场角色\n- 榛名亮（榛名 亮（はるな りょう），声：间岛淳司/须贺纪哉）\n\n	本作的主角。原特殊部队GAT的队员。军衔是准尉。少年时被父母抛弃，后因偶然契机加入统一军。在军队中表现十分优秀，立下了许多战功。\n\n	在国际性战争即将结束后，特殊部队被解散，前长官派他到第703研究所担任紫苑的护卫。\n- 紫苑（或译：诗音、希翁）（シオン（しおん），Sion，声：志村由美/丹下叶子）\n\n	以其毕生精力拯救了人类的少女，是一名Felix，是Felix中智慧最高的一员，地球脱出计划的中心人物。在工作了99年之后，结束工作的她留在了即将毁灭的地球，希望平静地度过余年。\n	实际年龄将近100岁，但是外表仍是一名少女。性格高傲，但是也有纯真的一面。\n\n- 艾莉卡（エリカ（えりか），Erica，声：中岛裕美子/山田ゆな）\n	\n	紫苑的姐姐，也是一名Felix，以前和紫苑一起进行研究，后来退役，以女仆的身份在照顾著妹妹。\n- 稻叶直人（稲葉 直人（いなば なおと），声：远近孝一/壬生中将）\n\n	第703研究所的护卫部队队长。军衔是少佐。他在多年前救了亮并介绍他入军队。\n- 浅井·F·拉维尼娅（浅井･F･ラヴィニア（あさい・えふ・らう゛ぃにあ），，Asai･F･Lavinia，声：中村绘里子/多々野仁美）\n\n	与亮一起被派往第703研究所的护卫部队队员。军衔是准尉。为人轻浮，但绝对服从命令。\n\n### 次要登场角色\n- 枣（或译：夏目）（ナツメ（はるな りょう），声：冈田纯子）\n\n	与小时候的亮生活一小段短时间的人物。虽然亮称她“姐姐”，但其实他们没有血缘关系。枣是从第703研究所逃走的Felix。她负责研发703研究所的地球脱出移民船的软件部分。虽然聪明才智不如紫苑，但也是Felix中优秀的人才。根据亮的说法，她与艾莉卡长的很像。\n\n- 塔野真夜（塔野 真夜（とうの まや），声：后藤麻衣/春川モモ）\n	\n	在最近很有人气的自由新闻记者。亮对她的评论是‘比我还要还要年轻一两岁的拉维’。充满精神的双马尾女孩，自己的发言常常会自爆。\n	从某出挖出紫苑在第703研究所的情报后，就很热情的不停提出采访要求，但理所当然的被稻叶少佐无视。笨蛋似的发言让人注目，是一个很热情的新闻记者。紫苑曾经看过她的采访影片。真夜主要以地球脱出计划的开发人员作为采访对象去取材，曾在几个二流的杂志发布新闻（当光提到二流杂志时，本人也无法否定）。以不成熟但读起来却十分的温柔且有趣的笔法撰写文章与关于紫苑的报导。紫苑对她的评价：“好的意义上的笨蛋”。\n	\n> 部分内容来自[萌娘百科](https://mzh.moegirl.org.cn/Eden*)，通过[署名-非商业性使用-相同方式共享 3.0中国大陆](https://creativecommons.org/licenses/by-nc-sa/3.0/cn/)引用\n> \n> 部分内容来自维基百科，通过[署名—相同方式共享 4.0 协议国际版](https://creativecommons.org/licenses/by-sa/4.0/deed.zh-hans)引用', '/uploads/images/Eden_hd.webp', 1739166927, '末日|奇幻', 10001, '/uploads/galres/0b40ac9a5a4be0864d65344dcdf93fb6.zip', 0, 2);
INSERT INTO `GALRES` VALUES (13, 'Memories Off', 'KID', '1999-09-30', '秋之回忆', '告别回忆', '《秋之回忆》（日语：メモリーズオフ，英语：Memories Off）是由KID于1999年推出的一款恋爱类AVG游戏，是《秋之回忆系列》的第一部作品，有前传作品《Memories Off Pure》由佐佐木睦美担任人设。', '## 雨，，何时会停？\n### 概括\n《秋之回忆》（日语：メモリーズオフ，英语：Memories Off）是由KID于1999年推出的一款恋爱类AVG游戏，是《秋之回忆系列》的第一部作品，有前传作品《Memories Off Pure》由佐佐木睦美担任人设。\n### 简介 \n\n淅淅沥沥的绵绵细雨。 \n\n漫长的等待，莫名的不安。 \n\n失去了主人的白色雨伞，滚落在路中央。\n \n闪烁的警灯，喧闹的人群。 \n\n混入了泥水的血红色。 \n\n还有不知是被泪水还是雨水模糊的双眼…… \n\nMemories Off讲述的是这样一个故事。 \n\n\n主人公三上智也原本是一名普普通通的学生， \n\n然而国中二年级时的一场意外，却彻彻底底地改变了他—— \n\n与自己青梅竹马的恋人桧月彩花在一个雨天为了给自己送雨伞，结果在过马路的时候被汽车撞到。 \n\n当在学校苦苦等待的智也听到远处传来的尖锐的警笛、感到不妙并发疯一样追赶过去的时候， \n\n却只看到了那柄滚落在地的雨伞——一柄白得耀眼的伞。 \n\n于是，从那一刻起…… \n\nMemories…Off… \n\n\n', '/uploads/images/秋之回忆.webp', 1743168045, '校园|催泪|恋爱', 10001, '/uploads/galres/c349a1bf218b13d963e19317d0296c27.zip', 0, 1);

-- ----------------------------
-- Table structure for IMGSTN
-- ----------------------------
DROP TABLE IF EXISTS `IMGSTN`;
CREATE TABLE `IMGSTN`  (
  `IID` int NOT NULL AUTO_INCREMENT,
  `iName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图像名称',
  `iAuthor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图像作者',
  `iFrom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图像来源',
  `iDesc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图像描述',
  `iPath` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图像路径',
  `iBy` int NULL DEFAULT NULL COMMENT '图像上传者',
  `iDateTime` int NULL DEFAULT NULL COMMENT '上传时间',
  `iHistory` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '图像操作历史',
  PRIMARY KEY (`IID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of IMGSTN
-- ----------------------------
INSERT INTO `IMGSTN` VALUES (9, '40578175_p0_Littlebusters!～refrain～完結記念', '', '', '', '/uploads/images/40578175_p0_Littlebusters!～refrain～完結記念.avif', 10001, NULL, NULL);
INSERT INTO `IMGSTN` VALUES (24, 'Summer_Pockets_Anime_KV', '', 'https://summerpockets-anime.jp/', 'SUMMER POCKETS动画视觉图', '/uploads/images/Summer_Pockets_Anime_KV.webp', 10001, 1738061699, '{\"1738061699\": \"10001上传了图像\"}');
INSERT INTO `IMGSTN` VALUES (32, 'チノちゃんタペストリー_58114839', '', 'Pixiv', '香风智乃', '/uploads/images/チノちゃんタペストリー_58114839.webp', 10001, 1738200661, '{\"1738200661\": \"10001上传了图像\"}');
INSERT INTO `IMGSTN` VALUES (35, '東方地霊殿_78521124', '', '', '', '/uploads/images/東方地霊殿_78521124.webp', 1, 1738238638, '{\"1738238638\": \"1上传了图像\"}');
INSERT INTO `IMGSTN` VALUES (36, '常轨脱离Creative', '', '', '常轨脱离Creative Cover', '/uploads/images/常轨脱离Creative.webp', 1, 1738650034, '{\"1738650034\": \"1上传了图像\"}');
INSERT INTO `IMGSTN` VALUES (37, 'Markdown编辑预览器', '幻想乡大城管博丽灵梦', '', '', '/uploads/images/Markdown编辑预览器.webp', 1, 1739066559, '{\"1739066559\": \"1上传了图像\"}');
INSERT INTO `IMGSTN` VALUES (42, 'SummerPockets', '', '', 'Summer Pockets封面', '/uploads/images/SummerPockets.webp', 1, 1739086336, '{\"1739086336\": \"1上传了图像\"}');
INSERT INTO `IMGSTN` VALUES (43, 'CLANNAD', '', '', 'CLANNAD封面', '/uploads/images/CLANNAD.webp', 10003, 1739108443, '{\"1739108443\": \"10003上传了图像\"}');
INSERT INTO `IMGSTN` VALUES (44, '星之梦', '', 'https://vndb.org/v34/cv#cv', 'planetarian ~Chiisana Hoshi no Yume & Snow Globe~ Download Edition', '/uploads/images/星之梦.webp', 10003, 1739114333, '{\"1739114333\": \"10003上传了图像\"}');
INSERT INTO `IMGSTN` VALUES (45, '想要传达给你的爱恋', '', '', '想要传达给你的爱恋封面', '/uploads/images/想要传达给你的爱恋.webp', 10001, 1739115906, '{\"1739115906\": \"10001上传了图像\"}');
INSERT INTO `IMGSTN` VALUES (46, '千恋＊万花_story_1', '', 'https://www.hikarifield.co.jp/senren/story.html', '千恋＊万花故事简介', '/uploads/images/千恋＊万花_story_1.webp', 10001, 1739152915, '{\"1739152915\": \"10001上传了图像\"}');
INSERT INTO `IMGSTN` VALUES (47, '千恋＊万花', '', '', '千恋＊万花封面', '/uploads/images/千恋＊万花.webp', 10001, 1739154413, '{\"1739154413\": \"10001上传了图像\", \"1739154495\": \"10001更新了图像\", \"1739154585\": \"10001更新了图像\"}');
INSERT INTO `IMGSTN` VALUES (48, 'ATRI-My_Dear_Moments', '', '', 'ATRI -My Dear Moments-', '/uploads/images/ATRI-My_Dear_Moments.webp', 10001, 1739159521, '{\"1739159521\": \"10001上传了图像\"}');
INSERT INTO `IMGSTN` VALUES (49, 'Eden_hd', '', '', 'Eden_hd', '/uploads/images/Eden_hd.webp', 10001, 1739166453, '{\"1739166453\": \"10001上传了图像\"}');
INSERT INTO `IMGSTN` VALUES (50, 'Eden_剧照', '', '', 'Eden_剧照', '/uploads/images/Eden_剧照.webp', 10001, 1739166704, '{\"1739166704\": \"10001上传了图像\"}');
INSERT INTO `IMGSTN` VALUES (51, 'この夏最強の女_82699176', '', 'Pixiv', '', '/uploads/images/この夏最強の女_82699176.webp', 2, 1739803822, '{\"1739803822\":\"2\\u4e0a\\u4f20\\u4e86\\u56fe\\u50cf\"}');
INSERT INTO `IMGSTN` VALUES (52, 'お掃除がんばります！_67988711', '', 'Pixiv', '', '/uploads/images/お掃除がんばります！_67988711.webp', 10002, 1739860804, '{\"1739860804\":\"10002\\u4e0a\\u4f20\\u4e86\\u56fe\\u50cf\"}');
INSERT INTO `IMGSTN` VALUES (53, '夏の能楽_92398792', '', 'Pixiv', '', '/uploads/images/夏の能楽_92398792.webp', 3, 1739861523, '{\"1739861523\":\"3\\u4e0a\\u4f20\\u4e86\\u56fe\\u50cf\"}');
INSERT INTO `IMGSTN` VALUES (54, 'Chino Sakura_105147143', '', '', '', '/uploads/images/Chino_Sakura_105147143.webp', 10001, 1739862723, '{\"1739862723\":\"10001\\u4e0a\\u4f20\\u4e86\\u56fe\\u50cf\"}');
INSERT INTO `IMGSTN` VALUES (56, '秋之回忆', '', '', '', '/uploads/images/秋之回忆.webp', 10001, 1743167563, '{\"1743167563\":\"10001\\u4e0a\\u4f20\\u4e86\\u56fe\\u50cf\"}');

-- ----------------------------
-- Table structure for USERS
-- ----------------------------
DROP TABLE IF EXISTS `USERS`;
CREATE TABLE `USERS`  (
  `UID` int NOT NULL AUTO_INCREMENT,
  `uNickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `uProfilePhoto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '/uploads/avatar/82420471_p0_静流.avif' COMMENT '用户头像',
  `uProfileCover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '/static/images/68315220_p0_春の魔法.avif' COMMENT '用户封面',
  `uRegDateTime` int NULL DEFAULT NULL COMMENT '用户注册时间',
  `uPasswd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户hash密码',
  `uEmail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户邮箱',
  `uGroupTags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '用户组标签',
  PRIMARY KEY (`UID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10008 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of USERS
-- ----------------------------
INSERT INTO `USERS` VALUES (1, '幻想乡大城管博丽灵梦', '/uploads/avatar/1.webp', '/uploads/images/東方地霊殿_78521124.webp', 1721544240, '7ee45ea855fa064038d5fe11dd1b01ee', 'ciallo@moegal.com', '{\"uGtags\": [\"众神眷恋的幻想乡\"]}');
INSERT INTO `USERS` VALUES (2, '⑨', '/uploads/avatar/2.avif', '/uploads/images/この夏最強の女_82699176.webp', 1739802249, 'f871c9ee379973c3e32e8cc191a1356d', 'chiruno@moegal.com', '{\"uGtags\": [\"众神眷恋的幻想乡\"]}');
INSERT INTO `USERS` VALUES (3, '本居小铃', '/uploads/avatar/3.webp', '/uploads/images/夏の能楽_92398792.webp', 1739859898, 'a5a4704985124f4b00240b35f607dd4e', 'kosuzu@moegal.com', '{\"uGtags\": [\"众神眷恋的幻想乡\"]}');
INSERT INTO `USERS` VALUES (10001, '香风智乃awsl', '/uploads/avatar/10001.webp', '/uploads/images/Chino_Sakura_105147143.webp', 1733285040, '7d6a6a5469d2629915e38e273a589390', 'Choutenngasuki@gmail.com', '{\"uGtags\": [\"Rabbit House应援组\"]}');
INSERT INTO `USERS` VALUES (10002, '奈津惠Meg', '/uploads/avatar/10002.webp', '/uploads/images/お掃除がんばります！_67988711.webp', 1733288100, '9a49e5878960d38512283bc169180ecd', 'megumi@moegal.com', '{\"uGtags\": [\"Rabbit House应援组\"]}');
INSERT INTO `USERS` VALUES (10003, '樱野玖璃梦', '/uploads/avatar/10003.webp', '/uploads/images/40578175_p0_Littlebusters!～refrain～完結記念.avif', 1735737900, '6e77b5da3c356b9963481c5e6b408d0b', 'Sakuranokurimu@moegal.com', '{\"uGtags\": [\"碧阳学园学生会\"]}');
INSERT INTO `USERS` VALUES (10004, '唐可可', '/uploads/avatar/82420471_p0_静流.avif', '/static/images/68315220_p0_春の魔法.avif', 1737954559, '6e77b5da3c356b9963481c5e6b408d0b', 'TangKuKuChan@outlook.com', '{\"uGtags\": []}');
INSERT INTO `USERS` VALUES (10005, '届恋', '/uploads/avatar/82420471_p0_静流.avif', '/static/images/68315220_p0_春の魔法.avif', 1739007583, '1c3c6ee6932226838abb4ba86b358b89', 'todokenai@moegal.moe', '{\"uGtags\": []}');
INSERT INTO `USERS` VALUES (10006, 'Eleina', '/uploads/avatar/82420471_p0_静流.avif', '/static/images/68315220_p0_春の魔法.avif', 1739782488, 'ec97dd54f3296791a59ae98f44bfb7b8', '3298389788@qq.com', '{\"uGtags\": []}');
INSERT INTO `USERS` VALUES (10007, '新堂彩音', '/uploads/avatar/10007.webp', '/static/images/68315220_p0_春の魔法.avif', 1739863227, '312c5a2840067f6a570c9b8558fc803c', 'ayane@moegal.com', NULL);

SET FOREIGN_KEY_CHECKS = 1;
