/*---------------------------------------------------------------------------

JavaScript StarField Background for Web Designers Toolkit
(C)1999-2003 USINGIT.COM, All Rights Reserved.
To get more free and professional scripts, visit:
http://www.usingit.com/
http://www.usingit.com/products/webtoolkit/index.html
email: support@usingit.com

You may use this script for free if you don't alert the copyright info.

---------------------------------------------------------------------------*/



var jsStarFieldBG_starTotal=100;
var jsStarFieldBG_starColorList=['white','gray','sliver'];
var jsStarFieldBG_stars=new Array();
var jsStarFieldBG_obj=new Object();
jsStarFieldBG_obj.ie4=(document.all&&!document.getElementById)?true:false;
jsStarFieldBG_obj.ns4=(document.layers)?true:false;
jsStarFieldBG_obj.ie5=(document.all&&document.getElementById)?true:false;
jsStarFieldBG_obj.ns6=(document.getElementById&&!document.layers&&!document.all)?true:false;
jsStarFieldBG_obj.dom=(document.getElementById)?true:false;
jsStarFieldBG_obj.x=0;
jsStarFieldBG_obj.y=0;
jsStarFieldBG_obj.cW=0;
jsStarFieldBG_obj.cH=0;
jsStarFieldBG_obj.lctX=0;
jsStarFieldBG_obj.lctY=0;
jsStarFieldBG_obj.deltaX=0;
jsStarFieldBG_obj.deltaY=0;
jsStarFieldBG_obj.jsStarFieldBG_scrollL=0;
jsStarFieldBG_obj.jsStarFieldBG_scrollT=0;
jsStarFieldBG_obj.offsetX=0;
jsStarFieldBG_obj.offsetY=0;
jsStarFieldBG_buildStars();
window.onresize=jsStarFieldBG_onResize;
window.onload=jsStarFieldBG_onLoad;

function jsStarFieldBG_updateWinProp(){
jsStarFieldBG_obj.cW=(jsStarFieldBG_obj.ie4||jsStarFieldBG_obj.ie5)?document.body.clientWidth:window.innerWidth;
jsStarFieldBG_obj.cH=(jsStarFieldBG_obj.ie4||jsStarFieldBG_obj.ie5)?document.body.clientHeight:window.innerHeight;
jsStarFieldBG_obj.offsetX=Math.floor(jsStarFieldBG_obj.cW/2);
jsStarFieldBG_obj.offsetY=Math.floor(jsStarFieldBG_obj.cH/2);
for(i=0;i<jsStarFieldBG_starTotal;i++)jsStarFieldBG_getStartPos(i);
}

function jsStarFieldBG_getStartPos(index){
var jsStarFieldBG_oStar=jsStarFieldBG_stars[index];
jsStarFieldBG_oStar.deltaX=Math.floor(Math.random()*25);
jsStarFieldBG_oStar.deltaY=Math.floor(Math.random()*25);
jsStarFieldBG_oStar.tL=Math.floor((jsStarFieldBG_oStar.deltaX+jsStarFieldBG_oStar.deltaY)/2);
jsStarFieldBG_oStar.lctX=(Math.floor(Math.random()*2)==1)?true:false;
jsStarFieldBG_oStar.lctY=(Math.floor(Math.random()*2)==1)?true:false;
jsStarFieldBG_oStar.crP=0;
var jsStarFieldBG_scrollL=(jsStarFieldBG_obj.ie4||jsStarFieldBG_obj.ie5)?document.body.scrollLeft:pageXOffset;
var jsStarFieldBG_scrollT=(jsStarFieldBG_obj.ie4||jsStarFieldBG_obj.ie5)?document.body.scrollTop:pageYOffset;
if(jsStarFieldBG_obj.ns4){
jsStarFieldBG_oStar.clip.width=0;
jsStarFieldBG_oStar.clip.height=0;
jsStarFieldBG_oStar.moveTo(jsStarFieldBG_obj.offsetX+jsStarFieldBG_scrollL,jsStarFieldBG_obj.offsetY+jsStarFieldBG_scrollT);
}else{
jsStarFieldBG_oStar.style.width=0;
jsStarFieldBG_oStar.style.height=0; 
jsStarFieldBG_oStar.style.top=jsStarFieldBG_obj.offsetY+jsStarFieldBG_scrollT+'px';
jsStarFieldBG_oStar.style.left=jsStarFieldBG_obj.offsetX+jsStarFieldBG_scrollL+'px';
}}

function jsStarFieldBG_moveStar(){
for(i=0;i<jsStarFieldBG_starTotal;i++){
var jsStarFieldBG_oStar=jsStarFieldBG_stars[i];
jsStarFieldBG_oStar.crP+=jsStarFieldBG_oStar.tL/70;
jsStarFieldBG_obj.x=jsStarFieldBG_oStar.deltaX*jsStarFieldBG_oStar.crP+jsStarFieldBG_oStar.crP;
jsStarFieldBG_obj.y=jsStarFieldBG_oStar.deltaY*jsStarFieldBG_oStar.crP+jsStarFieldBG_oStar.crP;
jsStarFieldBG_obj.jsStarFieldBG_scrollL=(jsStarFieldBG_obj.ie4||jsStarFieldBG_obj.ie5)?document.body.scrollLeft:pageXOffset;
jsStarFieldBG_obj.jsStarFieldBG_scrollT=(jsStarFieldBG_obj.ie4||jsStarFieldBG_obj.ie5)?document.body.scrollTop:pageYOffset;
var lc=(jsStarFieldBG_oStar.crP>.9)?Math.max(1,(jsStarFieldBG_oStar.crP/1)):0;
var lx=(jsStarFieldBG_obj.ns4)?jsStarFieldBG_oStar.left:parseInt(jsStarFieldBG_oStar.style.left);
var ly=(jsStarFieldBG_obj.ns4)?jsStarFieldBG_oStar.top:parseInt(jsStarFieldBG_oStar.style.top);
if(jsStarFieldBG_obj.ns4){
jsStarFieldBG_oStar.clip.width=jsStarFieldBG_oStar.clip.height=lc;
if((lx+jsStarFieldBG_obj.x+lc>=jsStarFieldBG_obj.cW+jsStarFieldBG_obj.jsStarFieldBG_scrollL)||(ly+jsStarFieldBG_obj.y+lc>=jsStarFieldBG_obj.cH+jsStarFieldBG_obj.jsStarFieldBG_scrollT)||(lx-jsStarFieldBG_obj.x*1.2<=jsStarFieldBG_obj.jsStarFieldBG_scrollL)||(ly-jsStarFieldBG_obj.y*1.5<=jsStarFieldBG_obj.jsStarFieldBG_scrollT))jsStarFieldBG_getStartPos(i);
else jsStarFieldBG_oStar.moveBy(((jsStarFieldBG_oStar.lctX)?jsStarFieldBG_obj.x:-jsStarFieldBG_obj.x),((jsStarFieldBG_oStar.lctY)?jsStarFieldBG_obj.y:-jsStarFieldBG_obj.y));
}else{
jsStarFieldBG_oStar.style.width=jsStarFieldBG_oStar.style.height=lc;
if((lx+jsStarFieldBG_obj.x+lc>=jsStarFieldBG_obj.cW+jsStarFieldBG_obj.jsStarFieldBG_scrollL)||(ly+jsStarFieldBG_obj.y+lc>=jsStarFieldBG_obj.cH+jsStarFieldBG_obj.jsStarFieldBG_scrollT)||(lx-jsStarFieldBG_obj.x*1.2<=jsStarFieldBG_obj.jsStarFieldBG_scrollL)||(ly-jsStarFieldBG_obj.y*1.5<=jsStarFieldBG_obj.jsStarFieldBG_scrollT))jsStarFieldBG_getStartPos(i);
else{
jsStarFieldBG_oStar.style.left=lx+((jsStarFieldBG_oStar.lctX)?jsStarFieldBG_obj.x:-jsStarFieldBG_obj.x)+'px';
jsStarFieldBG_oStar.style.top=ly+((jsStarFieldBG_oStar.lctY)?jsStarFieldBG_obj.y:-jsStarFieldBG_obj.y)+'px';
}}}}

function jsStarFieldBG_onResize(){
if(jsStarFieldBG_obj.ns4)setTimeout('history.go(0)',100);
else jsStarFieldBG_updateWinProp();
}
	
function jsStarFieldBG_onLoad(){
for(i=0;i<jsStarFieldBG_starTotal;i++)jsStarFieldBG_stars[i]=(jsStarFieldBG_obj.dom)?document.getElementById('star'+i):(jsStarFieldBG_obj.ns4)?document.layers['star'+i]:(jsStarFieldBG_obj.ie4)?document.all['star'+i]:null;
jsStarFieldBG_updateWinProp();
setInterval('jsStarFieldBG_moveStar()',(jsStarFieldBG_obj.ns6)?40:60);
}

function jsStarFieldBG_buildStars(){
var lc;
var ls='';
for(i=0;i<jsStarFieldBG_starTotal;i++){
lc=jsStarFieldBG_starColorList[Math.floor(Math.random()*jsStarFieldBG_starColorList.length)];
ls+='<div id="star'+i+'" style="font-size:1px;position:absolute;visibility:visible;background-color:'+lc+';layer-background-color:'+lc+'"></div>';
}
document.write(ls);
}