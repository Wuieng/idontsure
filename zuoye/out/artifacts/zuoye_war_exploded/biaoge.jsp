<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/20
  Time: 22:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title align=center>个人通讯录</title>
    <center><h1>个人通讯录</h1></center>
    <style>
        th, tr, td, table {
            border: 2px solid red;
        //border-bottom:groove;
        }

    </style>

</head>
<body>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<center>
    <center>
        <fieldset>
            <legend>输入想添加的人员资料</legend>
        <form >
            编号
            <input type="text" id="id"  placeholder="???"><br>
            姓名
            <input type="text" id="name"  placeholder="???"><br>
            号码
            <input type="text" id="num"  placeholder="???"><br>
            住址
            <input type="text" id="loc"  placeholder="???"><br>
            <input type="submit" value="提交" onClick="tian()">
        </form>
        </fieldset>
    </center>
    <input type="text" id="cname" style="margin-top: 1cm"  placeholder="请输入姓名" >
    <button id="bn" onclick="cha($('#cname').val())">查询</button><br>
<%--    style="display: none"--%>
<%--不想使用重定向，因为已经使用了ajax--%>
    <h5>模糊查询的数据会出现在下方红点处</h5>
    <table id="tca"  ></table><br>
<%--    貌似这里不谢跳转的目标表单的话，默认就是本页面，所以需要，重新添加--%>
<%--    所以考虑下就不提交表单查询后直接在本页面修改--%>

</center>



<%--<table id="table" align="center"></table>--%>
<table id="t1" align="center"></table>

<center>

    <h5>别点了，没写</h5>
    <a href="${pageContext.request.contextPath}/hel/zou">
        <button id="bt1" >添加数据就点我</button><br></a>
<%--    <button id="bt2" >就点我</button>--%>
</center>

<%--可以吧cha($('#cname').val())放到函数内部--%>
<script>


<%--    这里是主体界面--%>
//这里是主界面
    $(function(){
        // 失败alert($("#t1").rows.length);
        // $("#tca").hide();
        //确实在这里使用（）可以选择
        //但是貌似不能作为表格解析
        //没有必要隐藏，关键的写好了，只是有一个红点而已
        $.ajax({
            type: "POST",
            url:"hel/flist",
            contentType: "application/json; charset=utf-8",
            data:'{}',
            success: function(data){
                var s="<tr>";
                var s1= "<tr>\n" +
                    "<th>ID</th>\n" +
                    "<th>姓名</th>\n" +
                    "<th>电话号码</th>\n"+
                    "<th>住址</th>\n"+
                    "<th>数据操作</th>\n"+
                    "</tr>";
                var s2=s1;
                var s3="<tr>";
                $.each(data, function (i, item) {
                    //用于测试表一的代码
                    // s += "<th>" + item.id + "</th><th>" + item.name + "</th><th>" + item.number
                    //     + "</th><th>" + item.location + "</th></tr>";
                    // s1 += s;
                    // 这个表格设置成了除了id外都可编辑，所以为了界面考虑，显然完善的话，
                    // 是需要设置边界的,需要把数据操作也设置为不可编辑
                    s3+="<td >" + item.id + "</td><td contenteditable='true'>" + item.name +
                        "</td><td contenteditable='true'>" + item.number +
                        "</td><td contenteditable='true'>" + item.location +
                        "</td>"+"<td><button name= "+i+ " onclick='f(this.name)'>删除</button>\n" +
                        " <button  name= "+i+ " onclick='chn(this.name)'>修改</button></td>"+"</tr>";
                    s2+=s3;
                    // document.getElementById("table").innerHTML+=s;

                    s = "<tr>";
                    s3=s;
                });
                document.getElementById("t1").innerHTML=s2;


            }
        });
    });

//    注意我这里的修改和删除功能都是默认对

//接下来完成删除功能,先写读取button的功能
function f(index) {
    index++;
    var id=${"t1"}.rows[index].cells[0].innerText;
    //连带上了标题
    alert("将会删除id为"+id+"的数据");
    $.ajax({
        type: "POST",
        url: "hel/delete",
        contentType: "application/json; charset=utf-8",
        data: id,
        success: function (data) {
            alert("执行删除成功")
            window.location.reload();//刷新页面，或者删除表格行 $(row[i]).parent().parent().remove();
        //    现在来看刷新很舒服，但是在大量数据的情况下，可能界面就会比较的卡顿，所以需要分页
        }
    });
    //刷新表格和界面，可以考虑重定位，这样就不用重写方法了
    //修改和插入是新的页面
}
// 接下来是添加功能
function tian() {
//    我不打算逐个传参数了，浪费时间，直接选择器选择对应的表单元素
    var id=$("#id").val();
    var name=$("#name").val();
    // alert($("#t1").rows[0].cells[0].innerText);失败
    var num=$("#num").val();
    var loc=$("#loc").val();
    //应该也为修改加上
    if (id===""||name===""||num===""||loc===""){
        alert("数据有空，添加失败");
        return;
    }
    $.ajax({
        type: "POST",
        url: "hel/tian",
        contentType: "application/json; charset=utf-8",
        data:JSON.stringify({"id":id ,"name":name,
            "number":num,"location":loc}),
        success: function (data) {
            // 没有跳转执行
            alert("执行添加成功")
            //马上测试，还没有在后台添加功能
            //使用表单提交自带reload的功能
            window.location.reload();
        }

    });
}
//接下来完成修改功能，应该不需要刷新
function chn(index) {
    index++;
    var id=${"t1"}.rows[index].cells[0].innerText;
    var name=${"t1"}.rows[index].cells[1].innerText;
    var num=${"t1"}.rows[index].cells[2].innerText;
    var loc=${"t1"}.rows[index].cells[3].innerText;
    alert("将会修改id为"+id+"的数据");
    // alert($("t1").rows[0].cells[0].innerText);
    //两种语法吗？
    //这句化在定义的方法里无法运行
    $.ajax({
        type: "POST",
        url: "hel/chan",
        contentType: "application/json; charset=utf-8",
        data:JSON.stringify({"id":id ,"name":name,
            "number":num,"location":loc}),
        //实在不行重新定义一个类来写他，或者传列表
        success: function (data) {
            alert("执行修改成功")
            //马上测试，还没有在后台添加功能
            window.location.reload();//刷新页面，或者删除表格行 $(row[i]).parent().parent().remove();
            //    现在来看刷新很舒服，但是在大量数据的情况下，可能界面就会比较的卡顿，所以需要分页
        }
    });

}
//这里是查询功能
    function cha(s){
        $(function(){
                $.ajax({
                    // 编写json格式，设置属性和值
                    url:"hel/cha",
                    contentType:"application/json;charset=UTF-8",
                    data:s,
                    //data:s,可以成功的传值了
                    //那该怎么传多个属性，比如插入
                    dataType:"json",
                    type:"post",
                    success:function(data){
                        // data服务器端响应的json的数据，进行解析
                        // alert("执行了，看consle")
                        //*************************

                        var s1="<caption>查询的数据如下表</caption>"+
                            "<tr>\n" +
                            "<th>ID</th>\n" +
                            "<th>姓名</th>\n" +
                            "<th>电话号码</th>\n"+
                            "<th>住址</th>\n"+
                            "</tr>";
                        var s="<tr>";
                        var ji=0;
                        $.each(data, function (i, item) {
                            s+="<td>" + item.id + "</td><td>" + item.name + "</td><td>" + item.number
                                + "</td><td>" + item.location + "</td></tr>";
                            s1+=s;
                            s = "<tr>";
                            ji++;
                        });
                        if (ji===0){
                            alert("未找到");
                            document.getElementById("tca").innerHTML="";
                            return;
                        }
                        //$('#tca').style.display="block";
                        //document.getElementById("tca").style.display="block";
                        document.getElementById("tca").innerHTML=s1;
                    //***************************************

                    }
                });

        });
    }
    /*这个格式用来封装
var user_json = {
                "user_name": user_name,
                "user_mail":user_mail
            }  */


  /*  function getCellValue(taname) {
        // alert("y");
        alert("y");
        var obj = document.getElementById(taname);
        //for(var i=0;i<obj.rows.length;i++)
        alert(obj.rows.length)//ta拿到了obj貌似可以设置onclick
        alert(obj.rows[0].cells.length)
        //demost是div拿不到属性
        //alert(obj.rows(0).cells(0).innerHTML);

        alert(obj.rows[1].cells[0].innerText);//显示第2行，第1列的内容
        alert("yyy")
    }*/
//准备写的重用data建表方法
    function bio(data){
        var s1= "<tr>\n" +
            "<th>ID</th>\n" +
            "<th>姓名</th>\n" +
            "<th>电话号码</th>\n"+
            "<th>住址</th>\n"+
            "<th>数据操作</th>\n"+
            "</tr>";
        var s="<tr>";
        $.each(data, function (i, item) {
            s+="<td>" + item.id + "</td><td>" + item.name + "</td><td>" + item.number
                + "</td><td>" + item.location + "</td></tr>";
            s1+=s;
            s = "<tr>";
        });
        document.getElementById("t3").innerHTML=s1;
    }



</script>



</body>
</html>
