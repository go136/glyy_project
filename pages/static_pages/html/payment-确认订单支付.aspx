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
  <meta charset="UTF-8">
  <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>支付订单</title>

  <link rel="stylesheet" href="../stylesheet/payment.css" type="text/css"/>
  <script type="text/javascript" src="../js/jquery-1.8.2.min.js" ></script>

</head>

<body>
<!--头部  star-->
<header style="color:#fff">
  <a href="javascript:history.go(-1);">
    <div class="_left"><img src="../img/payment/left.png"></div><span>支付订单</span></a>
</header>
<!--头部 end-->
<!--内容 star-->
<div class="contaniner fixed-cont">
  <dl class="clas">
    <dt>
      <img src="../img/course/curliImg.png" alt="">
    </dt>
    <dd>
      <p class="list">
        <span><!-- 甘蓝阅读 by 百词斩40期 高阶层1 --></span>
        <strong>X 1</strong>
      </p>
      <p class="myChange">
        <span>已选：甘蓝40期高阶</span>
        <strong>￥ <em></em></strong>
      </p>
    </dd>
  </dl>
  <div class="stl">
    <p class="all">
      <strong>商品总价</strong>
      <span>￥ <em></em></span>
    </p>
    <p class="pos">
      <strong>邮费<small class="red">（满50包邮）</small></strong>
      <span class="blue">￥ <em>0</em></span>
    </p>
    <p class="sale">
      <strong>优惠</strong>
      <span class="red">-￥ <em>0</em></span>
    </p>
  </div>
  <div class="info">
    <p>
      给卖家留言：<input type="text" placeholder="在这里说明您的要求哦~~">
    </p>
    <p class="sale">
      优惠卷：
      <span class="blue"></span>
      <img src="../img/payment/right.png" alt="">
    </p>
  </div>
    <!--支付 star-->
  <div class="pay">
    <ul class="show">
      <li><label><img src="../img/payment/weixin.png" >微信支付<input name="Fruit" type="radio" value="" checked/><span></span></label> </li>
    </ul>
  </div>
    <!--支付 end-->
</div>
<footer>
    <a id="pay">付款</a>
    <small>元</small>
    <strong>129</strong>
    <span>实付</span>
</footer>
<!--内容 end-->

<!-- 优惠卷列表 -->
<div class="saleList">
  <ul>
    <!-- <li>优惠卷1</li> -->
  </ul>
</div>


<script type="text/javascript">
  function GetQueryString(name){
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if(r != true) return unescape(r[2]);
    return null;
  }
  var myClassId = GetQueryString("courseid");
  var user_token = "<%=userToken%>";
  var url = "https://cabage-english.chinacloudsites.cn";
  var myToken = "?token="+user_token;
  // 获取课程信息
  $.ajax({
      type: "get",
      /*async: true,*/
      url: url+"/api/get_course_byone.aspx"+myToken,
      data: {id:myClassId},
      dataType: "json",
      /*jsonp: "callback",*/
      success: function(data) {
        console.log(data.title);
        $(".list").find("span").text(data.title);
        $(".myChange").find("span").text("已选："+data.description);
        $(".clas").find("img").attr("src","https://newtimeenglishstorage.blob.core.chinacloudapi.cn/content/climg.png")
      },
      error: function(e) {
          alert("error");
      }
  })

  // 获取价格
  $.ajax({
      type: "get",
      /*async: true,*/
      url: url+"/api/get_course_price.aspx"+myToken,
      data: {courseid:myClassId},
      dataType: "json",
      /*jsonp: "callback",*/
      success: function(data) {
        var salePrice = data.info[0].price - data.info[0].discount;
        $(".myChange").find("strong em").text(salePrice);
        $(".stl .all").find("span em").text(salePrice);
        $("footer").find("strong").text(salePrice);
      },
      error: function(e) {
          alert("error");
      }
  })

  // 获取优惠卷列表
  $.ajax({
      type: "get",
      /*async: true,*/
      url: url+"/api/get_coupons.aspx"+myToken,
      data: {id:myClassId},
      dataType: "json",
      /*jsonp: "callback",*/
      success: function(data) {
        if(!$.isArray(data.coupons)){
            $(".sale").find(".blue").text("无优惠卷可用");
        }else if(data.coupons.length<1){
            $(".sale").find(".blue").text("无优惠卷可用");
        }else{
            $(".info").find(".sale").find("span").text(data[0].coupon_id);
            $(".stl").find(".sale").find("span em").text(data[0].coupon_discount);
            var posFir = $(".stl").find(".sale").find("span em").text();
            var ori = $(".myChange").find("strong em").text();
            $("footer").find("strong").text(ori-posFir);
            $(".info").click(function() {
              $(".saleList").show();
              $(".saleList").find("ul li").remove();
              $.each(data, function (n, value) {
                //console.log(value.coupon_id);
                if(value.coupon_status >= 0) {
                  $(".saleList").find("ul").append(
                    "<li value='"+ value.coupon_discount +"'>"+ value.coupon_id +"</li>"
                  )
                }
              })
              $(".saleList").find("ul").on("click","li",function() {
                var index = $(".saleList").find("ul li").index(this);
                //console.log(index);
                var pos = $(".saleList").find("ul li").eq(index).val();
                //console.log(pos);
                $(".saleList").hide();
                $(".sale").find(".blue").text(pos);
                $(".stl").find(".sale").find("span em").text(pos);
                var net = ori-pos;
                $("footer").find("strong").text(net);
              })
            })
        }
        // 无优惠卷可用

      },
      error: function(e) {
          alert("error");
      }
  })

  // 支付
  $("#pay").click(function() {
      $.ajax({
          type: "get",
          /*async: true,*/
          url: url+"/api/place_order.aspx"+myToken,
          data: {courseid:myClassId},
          dataType: "json",
          /*jsonp: "callback",*/
          success: function(data) {
            console.log(data.order_id);
              //$.get(url+"/payment/pay_order.aspx",{orderid:data.order_id,token:user_token})
            var jump_url = url + "/payment/pay_order.aspx?orderid=" + data.order_id + "&token=" + myToken;
            window.location.href = jump_url;
          },
          error: function(e) {
              alert("error");
          }
      })
  })
</script>

</body>
</html>