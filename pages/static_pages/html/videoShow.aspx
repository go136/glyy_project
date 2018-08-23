<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    public string openId = "";

    public string userToken = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        string currentPageUrl = Server.UrlEncode(Request.Url.ToString());
        if (Session["user_token"] == null || Session["user_token"].ToString().Trim().Equals(""))
        {
            Response.Redirect("../../../authorize.aspx?callback=" + currentPageUrl, true);
        }
        userToken = Session["user_token"].ToString().Trim();
        openId = WeixinUser.CheckToken(userToken);
        if (openId.Trim().Equals(""))
        {
            Response.Redirect("../../../authorize.aspx?callback=" + currentPageUrl, true);
        }

    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">  
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0, initial-scale=1.0, user-scalable=no">
    <title></title>
    <link rel="stylesheet" href="../stylesheet/base.css">
    <link rel="stylesheet" href="../stylesheet/video.css"/>
    <link rel="stylesheet" href="../stylesheet/frozen.css"/>
    <link rel="stylesheet" href="../stylesheet/bootstrap.min.css">
    <link rel="stylesheet" href="../stylesheet/bootstrap-switch.min.css">
    <link rel="stylesheet" href="../stylesheet/handout.css">
    <link rel="stylesheet" href="../stylesheet/zy.media.min.css">
    <style>
    	.videohrT .vtitle {
    		height: 30px;
    		line-height: 30px;
    		text-align:center;
    	}
    	.videoCnt .video {
    		/*margin-top: 40px;
    		height: 200px;*/
    		margin-top:13%;
    		height:250px;
    		overflow:hidden;
    		position:relative;
    	}
    	.change {
    		/*margin-top: 50px;*/	
    		position: fixed;
    		/*top: 430px;*/
    		top:10%;
    		right:3%;
    		/*right:0;*/
    		left:0;
    		text-align: right;
    		z-index:9999999999 !important;
    	}
    	.change a {
    		display: inline-block;
		    height: 30px;
		    line-height: 30px;
		    padding: 0 10px;
		    margin-right: 0px;
		    cursor: pointer;
    	}
    	.change a.set {
		    background-color: #99CCFF;
		    color: #fff;
		    border-radius: 4px;
    	}
    	.blog-header img {
    		width: 100%;
    	}
    	.videohrT {
    		z-index: 99;
    	}
    	.back {
    		width: 10px;
    		height: 10px;
    		border: 1px solid #ccc;
    		line-height: 10px;
    		text-align: center;
    		bakcground: #fff;
    		position: fixed;
    		bottom: 30px;
    		right: 10px;
    	}
    	.bootstrap-switch .bootstrap-switch-handle-off, .bootstrap-switch .bootstrap-switch-handle-on, .bootstrap-switch .bootstrap-switch-label{
    		padding:0 !important;
    	}
    </style>
    
</head>
<body>
<div id="tabdemo">
    <ul class="videohrT">
        <li rel="tab-1" class="vtitle" onclick="log_user_activity(event)" log-id="背景"  >背景</li>
        <li class="list"></li>
        <li rel="tab-2" class="vtitle" onclick="log_user_activity(event)" log-id="视频"   >视频</li>
        <li class="list"></li>
        <li rel="tab-3" class="vtitle"  onclick="log_user_activity(event)" log-id="音频"  >音频</li>
        <li class="list"></li>
        <li rel="tab-4" class="vtitle"  onclick="log_user_activity(event)" log-id="讲义" >讲义</li>
    </ul>
    <div rel="tab-1" class="content">
        <div class="box" id="box"></div>
    </div>
    <div rel="tab-2" class="content">
        <div class="videoCnt">
            <h1 class="videoCntName"></h1>
            <div class="video">
                <div class="zy_media" id="vvv">
                    <video id='video_1' poster="../img/curAdu/aduImg.jpg"  controls='true'
                           controlslist='nodownload nofullscreen' preload="auto" webkit-playsinline playsinline></video>
                    <input id="video_2" type="hidden" value=""/>
                    <input id="video_3" type="hidden" value=""/>
                </div>
            </div>
        </div>
        <div class="change">
        		<!--a id="url1" class="set">无字幕</a>
        		<a id="url2">英文字幕</a-->    
        		<div class="switch switch-mini">   		
            <input type="checkbox" name="vzm_checkbox" data-size="mini" data-on-text="字幕开" data-off-text="字幕关" data-on-color="primary" data-off-color="success"　checked>           
            </div>
            <!-- <div class="buttonOpen videoBtn" onclick="changeVideo()"></div> -->
        </div>
    </div>
    <div rel="tab-3" class="content">
        <div class="vdoSubtitle">
            <div class="vdoSubtle" style="font-size: 20px;font-family: Arial,'Times New Roman',Serif;color: #a5a5a5;">
                <div id="lyricContainer" style="position:relative;"><ul id='ulcontent'></ul></div>
                  
                <!--水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网水边%20各种空灵鸟叫_爱给网-->
            </div>
        </div>
        <div class="vdoSub row" style="margin:0px;border-top: 4px solid #ccc;">       	  
        	  <div class="col-xs-12" style="float:left;padding:0px;line-height:40px">
            <audio src="../img/video/水边%20各种空灵鸟叫_爱给网_aigei_com.mp3" controlsList="nodownload" controls="controls" id="audioUrl" style="position: relative;overflow: hidden;">
                Your browser does not support the audio element.
            </audio>
            </div>
        </div>
        
        <div class="change">
        		<!--a id="url1" class="set">无字幕</a>
        		<a id="url2">英文字幕</a-->    
        		<div class="switch switch-mini">   		
            <input type="checkbox" name="azm_checkbox" data-size="mini" data-on-text="语速慢" data-off-text="语速正" data-on-color="primary" data-off-color="success"　checked>           
            </div>
            <!-- <div class="buttonOpen videoBtn" onclick="changeVideo()"></div> -->
        </div>
    </div>
    <div rel="tab-4" class="content">
        <div class="container handout">
            <div class="blog-header">
            	  <div id="ktxi0">
               <!-- <h3>Andersen's Fairy Tale -chapter 10 -知识点总结</h3>
                <h4>2018-07-15 Eason 薄荷阅读MintReading</h4>
                <h4 class="narration">
                    薄荷阅读MintReading薄荷阅读MintReading薄荷阅读MintReading薄荷阅读MintReading薄荷阅读MintReading薄荷阅读MintReading薄荷阅读MintReading</h4>
                <audio src="../img/video/ai_xiao_de_yan_jing.mp3" controls="controls">
                    Your browser does not support the audio element.
                </audio>-->
              </div>
                <div class="handoutKw">
                    <h3 class="text-center">—重点单词—</h3>
                    <div id="zddc0"></div>
                </div>
                <div class="handoutEw">
                    <h3 class="text-center">—引申单词—</h3>
                    <div id="ysdc0"></div>
                </div>
                <div class="handoutEw">
                    <h3 class="text-center">—今日短语—</h3>
                    <div id="jrdy0"></div>
                </div>
                <div class="handoutPic">
                    <h3 class="text-center ">—重点句型—</h3>
                    <div id="zdjx0"></div>
                </div>
                <div class="handoutPic">
                    <h3 class="text-center ">—对话中文翻译—</h3>
                    <div id="dhzwfy0"></div>
                    <div id="dhimgdiv"></div>
                </div>
                <div class="handoutPic">
                    <h3 class="text-center ">—今日彩蛋—</h3>
                    <div id="yszsjj0"></div>
                    <div id="ysimgdiv"></div>
                </div>
                <div class="handoutPic">
                    <h3 class="text-center ">—每日一句—</h3>
                    <div class="dayImg">
                        <div id="mryj_img"></div>
                    </div>
                </div>
                <div class="handoutPic">
                    <h3 class="text-center copyright"></h3>
                    <div class="dayImg">
                        <div id = "bqsm"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="../js/jquery-3.3.1.min.js"></script>
<script src="../js/tabs.js"></script>
<script src="../js/bootstrap-switch.min.js"></script>
<script type="text/javascript"src="../js/log_user_activity.js" ></script>
<script type="text/javascript">

    var user_token = "<%=userToken%>";

    
    /*=====================================字幕滚动start=======================*/
        var audio;
        window.onload = function(){
            audio=document.getElementById("audioUrl");
            var storage = window.localStorage;
            //字幕URL
            var audio_caption_file_url = storage.getItem("audio_caption_file_url");
            
            //显示歌词的元素
            var lyricContainer = $("#lyricContainer");
            //获取lrc转换成的字幕文件的
            var lrcText = "[00:00.17]庭竹 - 公主的天堂\n" +
                "[00:05.40]作曲:陈嘉唯、Skot Suyama 陶山、庭竹\n" +
                "[00:07.33]作词:庭竹\n" +
                "[00:15.59]风铃的音谱 在耳边打转\n" +
                "[00:18.62]城堡里 公主也摆脱了黑暗的囚禁\n" +
                "[00:22.82]她一点点地 无声悄悄地慢慢长大\n" +
                "[00:26.36]期待着 深锁木门后的世界\n" +
                "[01:38.72][00:29.76]\n" +
                "[01:51.48][00:30.32]树上 小鸟的轻响 在身边打转\n" +
                "[01:55.35][00:34.09]公主已 忘记木制衣橱背后的惆怅\n" +
                "[01:59.65][00:38.35]她跳舞唱歌天真无邪地寻找属于自己的光亮和快乐\n" +
                "[02:06.98][00:45.76]\n" +
                "[02:07.41][00:46.06]树叶一层层拨开了伪装\n" +
                "[02:11.29][00:50.25]彩虹一步步露出美丽脸庞 无限的光亮\n";
            //var lrcText = getLyric(audio_caption_file_url);
            var lrcText = audio_caption_file_url;
            //通过正则拆分的字幕arr
            var resultArr = parseLyric(lrcText);

            var h = "";
            for(var j = 0; j<resultArr.length; j++){
                //h += "<p id='"+resultArr[j][0]+"'>"+resultArr[j][1]+"</p>";
                h += "<li id='"+j+"'>"+resultArr[j][1]+"</li>";
            }
            $("#lyricContainer ul").html(h);

            var html = "";
            var inner = "";
            audio.ontimeupdate = function(e) {
                //遍历所有歌词，看哪句歌词的时间与当然时间吻合
                /*for (var i = 0, l = resultArr.length; i < l; i++) {
                    if (this.currentTime > resultArr[i][0]) {
 
                        if (html.indexOf(resultArr[i][1]) == -1){

                            for(var k = 0; k<resultArr.length; k++){
                                if (resultArr[i][0] == resultArr[k][0]){
                                    html += "<p class='markContent' id='inner' style='color:#99CCFF' id='"+resultArr[k][0]+"'>"+resultArr[k][1]+"</p>";
                                }else {
                                    html += "<p id='"+resultArr[k][0]+"'>"+resultArr[k][1]+"</p>";
                                }
                            }
                            $("#lyricContainer").html(html);
                            
                            html = ""; 
                        }
                    };
                }; 
                       
								var inner=document.getElementById("inner");
								console.log(inner.offsetTop);
								$("#lyricContainer").animate({top:"-"+inner.offsetTop+"px"}, 500);
								*/
								
								for (var i = 0, l = resultArr.length; i < l; i++) {    
										if (this.currentTime> resultArr[i][0]){
										//$('#lyricContainer ul').css('top',-i*40+200+'px'); //让歌词向上移动    
										$('#lyricContainer ul li').css('color','#a5a5a5');    
										$('#lyricContainer ul li:nth-child('+(i+1)+')').css('color','red'); //高亮显示当前播放的哪一句歌词  
										//var inner=$('#lyricContainer ul li:nth-child('+(i+1)+')');
										inner=document.getElementById(''+(i+1)+'');

										}
								}
								$("#ulcontent").animate({top:"-"+inner.offsetTop+"px"}, 500); 
								inner="";
            };
        }

        function getLyric(url) {
        	  var lyric;
            //建立一个XMLHttpRequest请求
             var request = new XMLHttpRequest();
            //配置, url为歌词地址，比如：'./content/songs/foo.lrc'
            request.open('GET', url, false);
            //因为我们需要的歌词是纯文本形式的，所以设置返回类型为文本
            request.responseType = 'text';
            //一旦请求成功，但得到了想要的歌词了
            request.onload = function() {
                //这里获得歌词文件
            lyric = request.response;
            };
            //向服务器发送请求
            request.send();
            
            
            return lyric.responseText;
        }


        function parseLyric(text) {
            //将文本分隔成一行一行，存入数组
            var lines = text.split('\n'),
                //用于匹配时间的正则表达式，匹配的结果类似[xx:xx.xx]
                pattern = /\[\d{2}:\d{2}.\d{2}\]/g,
                //保存最终结果的数组
                result = [];
            //去掉不含时间的行
            while (!pattern.test(lines[0])) {
                lines = lines.slice(1);
            };
            //上面用'\n'生成生成数组时，结果中最后一个为空元素，这里将去掉
            lines[lines.length - 1].length === 0 && lines.pop();
            lines.forEach(function(v /*数组元素值*/ , i /*元素索引*/ , a /*数组本身*/ ) {
                //提取出时间[xx:xx.xx]
                var time = v.match(pattern),
                    //提取歌词
                    value = v.replace(pattern, '');
                //因为一行里面可能有多个时间，所以time有可能是[xx:xx.xx][xx:xx.xx][xx:xx.xx]的形式，需要进一步分隔
                time.forEach(function(v1, i1, a1) {
                    //去掉时间里的中括号得到xx:xx.xx
                    var t = v1.slice(1, -1).split(':');
                    //将结果压入最终数组
                    result.push([parseInt(t[0], 10) * 60 + parseFloat(t[1]), value]);
                });
            });
            //最后将结果数组中的元素按时间大小排序，以便保存之后正常显示歌词
            result.sort(function(a, b) {
                return a[0] - b[0];
            });
            return result;
        }





        /*=====================================字幕滚动end==========================*/


    $(".videoBtn").click(function () {
        if ($(this).hasClass("buttonOpen")) {
            $(this).removeClass("buttonOpen").addClass("buttonOff");
        } else {
            $(this).removeClass("buttonOff").addClass("buttonOpen");
        }
    });
        $("#url1").click(function(){
					changeVideo();
					$(this).addClass("set").siblings("a").removeClass("set");
        })
        $("#url2").click(function(){
        		changeVideo();
					$(this).addClass("set").siblings("a").removeClass("set");
        })

    function changeVideo() {
        var flag = $("#video_3").val();
        if (flag == "video_1"){
            var video1Url = $("#video_1").attr("src");
            var video2Url = $("#video_2").val();

            $("#video_1").attr("src", video2Url);
           $("#video_2").attr("value", video1Url);
           $("#video_3").attr("value", "video_2");
        }else if(flag == "video_2"){
           var video1Url = $("#video_1").attr("src");
            var video2Url = $("#video_2").val();

            $("#video_1").attr("src", video2Url);
            $("#video_2").attr("value", video1Url);
            $("#video_3").attr("value", "video_1");
        }
    }


    $(function () {
        tabs_takes.init("tabdemo");
    })

    $(document).ready(function () {
    	      //初始化视频字幕切换按钮
    	      $("[name='vzm_checkbox']").bootstrapSwitch({
    	      	//size:"mini",
							onSwitchChange:function(event,state){
								changeVideo();  	      	
							}
    	      });
            //初始化音频字幕切换按钮
    	      $("[name='azm_checkbox']").bootstrapSwitch({
    	      	//size:"mini",
							onSwitchChange:function(event,state){
									      	
							}
    	      });
    	          	
            var storage = window.localStorage;
            //视频URL
            var media_url = storage.getItem("media_url");
            //音频URL
            var audioUrl = storage.getItem("audioUrl");
            var videoUrls = media_url.split(",");

            $("#audioUrl").attr("src" , audioUrl);

            if (videoUrls.length>0){
                if (videoUrls.length == 1){
                    $("#video_1").attr("src", videoUrls[0]);
                    $("#video_3").attr("value", "video_1");
                }else if(videoUrls.length == 2){
                    $("#video_1").attr("src", videoUrls[0]);
                    $("#video_2").attr("value", videoUrls[1]);
                    $("#video_3").attr("value", "video_1");
                }
            }
            var lessons_id = storage.getItem("lessons_id");
            var short_content = storage.getItem("short_content");
            $("#box").html("<div>" + short_content + "</div>");
            
        });

    function getRootPath() {
        var curWwwPath = window.document.location.href;
        var pathName = window.document.location.pathname;
        var pos = curWwwPath.indexOf(pathName);
        var localhostPaht = curWwwPath.substring(0, pos);
        var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
        return (localhostPaht + projectName);
    }


    $(document).ready(function () {
        var storage = window.localStorage;
        var lessonsid = storage.getItem("lessons_id");
        getContent(lessonsid);
    });

    function getContent(o) {
        $.ajax({
            type: "post",
            url: "https://weixin-new-time-english.chinacloudsites.cn/api/get_handout_of_lesson.aspx",
            data: {"lessonid": o},
            success: function (data) {
                if (data.status == 0) {
                    if (data.handouts.length > 0) {
                    	  var ktxi = new Array();
                        var zddc = new Array();
                        var ysdc = new Array();
                        var jrdy = new Array();
                        var zdjx = new Array();
                        var dhzwfy = new Array();
                        var yszsjj = new Array();
                        var bqsm = new Array();
                        var mryj = new Array();
                        for (var i = 0; i < data.handouts.length; i++) {
                        	  if (data.handouts[i].type == "开头信息") {
                                ktxi.push(data.handouts[i]);
                            } 
                            else if (data.handouts[i].type == "重点单词") {
                                zddc.push(data.handouts[i]);
                            } else if (data.handouts[i].type == "引申单词") {
                                ysdc.push(data.handouts[i]);
                            } else if (data.handouts[i].type == "今日短语") {
                                jrdy.push(data.handouts[i]);
                            } else if (data.handouts[i].type == "重点句型") {
                                zdjx.push(data.handouts[i]);
                            } else if (data.handouts[i].type == "对话中文翻译") {
                                dhzwfy.push(data.handouts[i]);
                            } else if (data.handouts[i].type == "今日彩蛋") {
                                yszsjj.push(data.handouts[i]);
                            }else if (data.handouts[i].type == "版权声明") {
                                bqsm.push(data.handouts[i]);
                            }else if (data.handouts[i].type == "每日一句") {
                                mryj.push(data.handouts[i]);
                            }
                        }
                        innktxi(ktxi);
                        innzddc(zddc);
                        innysdc(ysdc);
                        innjrdy(jrdy);
                        innzdjx(zdjx);
                        inndhzwfy(dhzwfy);
                        innyszsjj(yszsjj);
                        innbqsm(bqsm);
                        innmryj(mryj);
                    }
                } else {
                    alert("接口异常");
                }
            }
        });
    }

    function innktxi(o){
         if (o.length > 0) {
            var html = "";
            var j = 1;
            for (var i = 0; i < o.length; i++) {
            	 if (o[i].medias.length > 0) {
                if (o[i].medias[0].type == "audio") {
                        html = html + "<div style='text-align:center'><audio src='" + o[i].medias[0].media_url + "' controlsList='nodownload' controls='controls'>Your browser does not support the audio element.</audio></div>";
                  }
                } else {
                      html = html + "<div>" + o[i].english_content + o[i].chinese_content + "</div>";
                    j++;
                
              }
            }
            $("#ktxi0").html(html);
        }   	   	
    }

    function innzddc(o) {
        if (o.length > 0) {
            var html = "";
            var j = 1;
            for (var i = 0; i < o.length; i++) {
                if (o[i].medias.length > 0) {
                    if (o[i].medias[0].type == "audio") {
                        html = html + "<img src='" + o[i].medias[0].media_url + "' class='img-responsive' alt='Responsive image'>";
                    }
                } else {
//                    html = html + "<div>"+ j+"." + o[i].english_content + ":"+o[i].chinese_content+"</div>";
//                    html = html + "<div>" + j + "." + o[i].english_content + ":" + o[i].chinese_content + "</div>";
                      html = html + "<div>" + o[i].english_content + o[i].chinese_content + "</div>";
                    j++;
                }
            }
            $("#zddc0").html(html);
        }
    }

    function innysdc(o) {
        if (o.length > 0) {
            var html = "";
            var j = 1;
            for (var i = 0; i < o.length; i++) {
                if (o[i].medias.length > 0) {
                    if (o[i].medias[0].type == "picture") {
                        html = html + "<img src='" + o[i].medias[0].media_url + "' class='img-responsive' alt='Responsive image'>";
                    }
                } else {
                	    html = html + "<div>" + o[i].english_content +"</div>";
                    //html = html + "<div>" + j + "." + o[i].english_content + ":" + o[i].chinese_content + "</div>";
                    j++;
                }
            }
            $("#ysdc0").html(html);
        }
    }

    function innjrdy(o) {
        if (o.length > 0) {
            var html = "";
            var j = 1;
            for (var i = 0; i < o.length; i++) {
                if (o[i].medias.length > 0) {
                    if (o[i].medias[0].type == "picture") {
                        html = html + "<img src='" + o[i].medias[0].media_url + "' class='img-responsive' alt='Responsive image'>";
                    }
                } else {
                    //html = html + "<div>" + j + "." + o[i].english_content + ":" + o[i].chinese_content + "</div>";
                    html = html + "<div>" +  o[i].english_content + "</div>";
                    j++;
                }
            }
            $("#jrdy0").html(html);
        }
    }

    function innzdjx(o) {
        if (o.length > 0) {
            var html = "";
            var j = 1;
            for (var i = 0; i < o.length; i++) {
                if (o[i].medias.length > 0) {
                    if (o[i].medias[0].type == "picture") {
                        html = html + "<img src='" + o[i].medias[0].media_url + "' class='img-responsive' alt='Responsive image'>";
                    }
                } else {
                	    html = html + "<div>"+ o[i].english_content + "</div>";
                    //html = html + "<div>" + j + "." + o[i].english_content + ":" + o[i].chinese_content + "</div>";
                    j++;
                }
            }
            $("#zdjx0").html(html);
        }
    }

    function inndhzwfy(o) {
        if (o.length > 0) {

            var html = "";
            var j = 1;
            for (var i = 0; i < o.length; i++) {
                if (o[i].medias.length > 0) {
                    if (o[i].medias[0].type == "picture") {
                        html = html + "<img src='" + o[i].medias[0].media_url + "' class='img-responsive' alt='Responsive image'>";
                    }
                } else {
                    if (o[i].english_content.length > 3) {
                        //html = html + "<div>" + j + "." + o[i].english_content + ":" + o[i].chinese_content + "</div>";
                        html = html + "<div>" +  o[i].english_content + "</div>";
                        j++;
                    } else {
                        //html = html + "<div>" + j + "." + o[i].english_content + ":" + o[i].chinese_content + "</div>";
                        html = html + "<div>" + o[i].english_content + "</div>";
                        j++;
                    }
                }
            }
            $("#dhzwfy0").html(html);
        }
    }

    function innyszsjj(o) {
        if (o.length > 0) {

            var html = "";
            var j = 1;
            for (var i = 0; i < o.length; i++) {
                if (o[i].medias.length > 0) {
                    if (o[i].medias[0].type == "picture") {
                        html = html + "<img src='" + o[i].medias[0].media_url + "' class='img-responsive' alt='Responsive image'>";
                    }
                } else {
                    if (o[i].english_content.length>0 && o[i].chinese_content.length>0){
                        html = html + "<div>"  + o[i].english_content + "" + o[i].chinese_content + "</div>";
                        //html = html + "<div>" + j + "." + o[i].english_content + ":" + o[i].chinese_content + "</div>";
                        j++;
                    }else if (o[i].english_content.length == 0){
                        html = html + "<div>" + o[i].chinese_content + "</div>";
                        //html = html + "<div>" + j + "." + o[i].chinese_content + "</div>";
                        j++;
                    }else if (o[i].chinese_content.length == 0){
                        html = html + "<div>" + o[i].english_content + "</div>";
                        //html = html + "<div>" + j + "." + o[i].english_content + "</div>";
                        j++;
                    }
                }
            }
            $("#yszsjj0").html(html);
        }
    }

    function innbqsm(o) {
        if (o.length > 0) {

            var html = "";
            for (var i = 0; i < o.length; i++) {
                if (o[i].medias.length > 0) {
                    if (o[i].medias[0].type == "picture") {
                        html = html + "<img src='" + o[i].medias[0].media_url + "' class='img-responsive' alt='Responsive image'>";
                    }
                } else {
                    if (o[i].english_content.length>0&&o[i].chinese_content.length>0){
                        html = html + "<div>" + o[i].english_content + "" + o[i].chinese_content + "</div>";
                    }else{
                        html = html + "<div>" + o[i].english_content + "</div>";
                    }
                }
            }
            $("#bqsm").html(html);
        }
    }


    function innmryj(o) {
        if (o.length > 0) {

            var html = "";
            for (var i = 0; i < o.length; i++) {
                if (o[i].medias.length > 0) {
                    if (o[i].medias[0].type == "picture") {
                        html = html + "<img src='" + o[i].medias[0].media_url + "' class='img-responsive' alt='Responsive image'>";
                    }
                } else {
                    if (o[i].english_content.length>0){
                        html = html + "<div>" + o[i].english_content + ":" + o[i].chinese_content + "</div>";
                    }else{
                        html = html + "<div>" + o[i].chinese_content + "</div>";
                    }
                }
            }
            $("#mryj_img").html(html);
        }
    }

</script>
</html>