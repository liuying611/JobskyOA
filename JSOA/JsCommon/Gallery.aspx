﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Gallery.aspx.cs" Inherits="JsCommon_Gallery" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>时光画馆</title>
    <script type="text/javascript" src="../JS/Gallery.js"></script>
    
    <link href="../CSS/Gallery.css" rel="stylesheet" type="text/css"/>
</head>
<body >
    <form id="form1" runat="server">

        <!--改写视图为模板字符串-->
    <div class="wrap" id="wrap">
        <!--photo负责平移、旋转-->
        <div class="photo photo_center photo_front" onclick="turn(this)" id="photo_{{index}}">
            <!--photo-wrap负责翻转-->
            <div class="photo-wrap">
                <div class="side side-front">
                <p class="image"><img src="../Image/Gallery/{{img}}"/></p>
                <p class="caption">{{caption}}</p>
            </div>
            <div class="side side-back">
                <p class="desc">{{desc}}</p>
            </div>
            </div>   
        </div>
    </div>
        <script type="text/javascript">
            
            function g(selector) {
                var method = selector.substr(0, 1) == '.' ? 'getElementsByClassName' : 'getElementById';
                return document[method](selector.substr(1));
            }
            //随机生成一个值 
            function random(range) {
                var max = Math.max(range[0], range[1]);
                var min = Math.min(range[0], range[1]);
                var diff = max - min;
                var number = Math.ceil(Math.random() * diff + min);
                return number;
            }
            //输出所有的对象
            var data = data;
            function addPhotos() {
                var template = g('#wrap').innerHTML;
                var html = [];
                var nav = [];
                //输出控制按钮，每一控制按钮，都对应一个海报
                for (s in data) {
                    var _html = template
                        .replace('{{index}}', s)
                        .replace('{{img}}', data[s].img)
                        .replace('{{caption}}', data[s].caption)
                        .replace('{{desc}}', data[s].desc);
                    html.push(_html);

                    nav.push('<span id="nav_' + s + '" onclick="turn(g(\'#photo_'+s+'\'))" class="i"></span>');
                }
                html.push('<div class="nav">' + nav.join('') + '<div>');
                g('#wrap').innerHTML = html.join('');
                rsort(random([0, data.length]));
            }
            addPhotos();
            //计算左右分区范围
            function range() {
                var range = { left: { x: [], y: [] }, right: { x: [], y: [] } };
                var wrap = {
                    w: g('#wrap').clientWidth,
                    h: g('#wrap').clientHeight
                    
                }
                var photo = {
                    w: 320,
                    h: 260
                }
                range.wrap = wrap;
                range.photo = photo;
                range.left.x = [-300,380];
                range.left.y = [-210,580];
                range.right.x = [700,1350];
                range.right.y = range.left.y;
                return range;
            }
            //排序海报
            function rsort(n) {
                var _photo = g('.photo');
                var photos = [];
                for (s = 0; s < _photo.length; s++) {
                    _photo[s].className = _photo[s].className.replace(/\s*photo_center\s*/, ' ');
                    _photo[s].className = _photo[s].className.replace(/\s*photo_front\s*/, ' ');
                    _photo[s].className = _photo[s].className.replace(/\s*photo_back\s*/, ' ');

                    _photo[s].className += ' photo_front ';
                    _photo[s].style.left = '';
                    _photo[s].style.top = '';
                    _photo[s].style['-webkit-transform'] = 'rotate(360deg) scale(1.5)';
                    _photo[s].style['-moz-transform'] = 'rotate(360deg) scale(1.5)';
                    photos.push(_photo[s]);
                }
                var photo_center = g('#photo_' + n);
                photo_center.className += ' photo_center ';
                photo_center = photos.splice(n, 1)[0];
                //海报分两边
                var photo_left = photos.splice(0, Math.ceil(photos.length / 2));
                var photo_right = photos;
                var ranges = range();
                for (s in photo_left) {
                    var photo = photo_left[s];
                    photo.style.left = random(ranges.left.x) + 'px';
                    photo.style.top = random(ranges.left.y) + 'px';
                    photo.style['-webkit-transform'] = 'rotate(' + random([-150, 150]) + 'deg) scale(1)';
                    photo.style['-moz-transform'] = 'rotate(' + random([-150, 150]) + 'deg) scale(1)';
                }
                for (s in photo_right) {
                    var photo = photo_right[s];
                    photo.style.left = random(ranges.right.x) + 'px';
                    photo.style.top = random(ranges.right.y) + 'px';
                    photo.style['-webkit-transform'] = 'rotate(' + random([-150, 150]) + 'deg) scale(1)';
                    photo.style['-moz-transform'] = 'rotate(' + random([-150, 150]) + 'deg) scale(1)';
                }

                //控制按钮处理
                var navs = g('.i');
                for (var s = 0; s < navs.length; s++)
                {
                    navs[s].className = navs[s].className.replace(/\s*i_current\s*/, ' ');
                    navs[s].className = navs[s].className.replace(/\s*i_back\s*/, ' ');
                }
                g('#nav_' + n).className += ' i_current ';
                console.log(photo_left.length, photo_right.length)
            }
            function turn(elem) {
                var cls = elem.className;
                var n = elem.id.split('_')[1];

                if (!/photo_center/.test(cls)) {
                    return rsort(n);
                }

                if (/photo_front/.test(cls)) {
                    cls = cls.replace(/photo_front/, 'photo_back');
                    g('#nav_' + n).className += ' i_back ';
                } else {
                    cls = cls.replace(/photo_back/, 'photo_front')
                    g('#nav_' + n).className = g('#nav_' + n).className.replace(/\s*i_back\s*/, ' ');
                }
                return elem.className = cls;
            }
    </script>
    </form>
</body>
</html>
