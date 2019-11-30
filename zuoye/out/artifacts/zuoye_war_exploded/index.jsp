<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/10
  Time: 18:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
  <head>
    <title>测试一波</title>
  </head>
  <body>
  <h1>初始界面</h1><br>

  <a href="${pageContext.request.contextPath}/hel/hi">dadda</a><br>
  <div id="demost1" align=center></div><br>
  <div id="demost2" align=center></div><br>
  <table id="ta" border="2" align=center ></table>
  <table id="ta1" border="2" align=center ></table>
  <button id="btn">发送ajax请求并回收数据</button><br>
  <button id="bts">发送ajax请求</button><br>
  <button id="btc">发送ajax请求，并异步处理</button><br>
  <button id="btl">发送ajax请求，得到数据遍历显示</button><br>
  <p id="demost"></p>
  <a href="${pageContext.request.contextPath}/hel/hi">dadda</a>



  <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
  <script src="lala.js"></script>
<%--  先暂时不使用引用外部文件之后在说--%>
  <script>
    $(function(){
      $("#btn").click(function () {
        alert("hello !");
        $.ajax({
          // 编写json格式，设置属性和值
          url:"hel/getrequ",
          contentType:"application/json;charset=UTF-8",
          data:'{"name":"hehe","age":18}',
          dataType:"json",
          type:"post",
          success:function(data){
            // data服务器端响应的json的数据，进行解析
          }
        });
      });
    });



    $(function(){
      $("#bts").click(function () {
        alert("hello ");
        $.ajax({
          // 编写json格式，设置属性和值
          url:"hel/aj",
          contentType:"application/json;charset=UTF-8",
          data:'{"name":"hehe","age":18}',
          dataType:"json",
          type:"post",
          success:function(data){
            // data服务器端响应的json的数据，进行解析
            alert("hello btn!");
            document.write("rerer");
          }
        });

      });
    });



    $(function(){
      $("#btc").click(function () {
        $.ajax({
          // 编写json格式，设置属性和值
          url:"hel/getreqback",
          contentType:"application/json;charset=UTF-8",
          data:'{"name":"hehe","age":18}',
          dataType:"json",
          type:"post",
          success:function(data){
            // data服务器端响应的json的数据，进行解析
            alert(data.toString());
            alert(data.name)
            alert(data.age)
          }
        });

      });
    });
    //下面这个可以用于开始就显示数据
    $(function(){
        $.ajax({
          type: "POST",
          url:"hel/flist",
          contentType: "application/json; charset=utf-8",
          data:'{}',
          //这里想要交互没有那么简单，必须要传数据，因为我这里的函数修改威了接受数据的
          //所以最好在做修改的时候再使用Ajax
          //这里还得想下是否一定要用ajax，为什么不重定位到另外的页面，然后在交互数据
          //用ajax直接传对象，然后再开一个页面应该也可以做到，，
          success: function(data){
            var s="<tr>";
            var s1="<table border=\"1\">\n" +
                    "<tr>\n" +
                    "<th>ID</th>\n" +
                    "<th>姓名</th>\n" +
                    "<th>电话号码</th>\n"+
                    "<th>住址</th>\n"+
                    "<th>数据操作</th>\n"+
                    "</tr>";
            var s2=s1;
            var s3="<tr>";
            $.each(data, function (i, item) {
              s += "<th>" + item.id + "</th><th>" + item.name + "</th><th>" + item.number
                                + "</th><th>" + item.location + "</th></tr>";
                    s1 += s;
              //      这里的s3已经改成了td单元格的模式了
              s3+="<td>" + item.id + "</td><td>" + item.name + "</td><td>" + item.number
                      + "</td><td>" + item.location + "</td></tr>";
                    s2+=s3;
              document.getElementById("ta").innerHTML+=s;
              document.getElementById("ta1").innerHTML+=s3;
              //成功的添加了元素
                  s = "<tr>";
                  s3=s;

                });
              // s="</<tr>
              //         < td >item.id < /td>
              //
              //         < /tr>>"
            s1+="</table>";
            document.getElementById("demost1").innerHTML=s1;
            document.getElementById("demost2").innerHTML=s2;


            }
          });
        });



    $(function(){
      $("#btl").click(function () {

        $.ajax({
          type: "POST",
          url:"hel/flist",
          contentType: "application/json; charset=utf-8",
          data:'{"name":"heh57575e","age":18}',
          //data用于传给后台，第一波
          //上面这两行没有也成功了，可能会影响中文编码
          //上面写得data是什么，并不重要，这只是一个对象，被初始化。
          //甚至不写，也可以，只是初始化了data={},也行，看你是否想要传值给后台处理了
          <%--url: "${pageContext.request.contextPath}/sys/user?getUser",--%>
          // 是不是上面写了data就定义了data了
          success: function(data){
            var s="";

            //data.CHANGE
            // x=data.toArray()
            // for (i=0;i<x.length;i++)
            // {
            //   alert(x[i].innerHTML);
            //   s1+=x[i].name+" ";
            // }
            var s1="<table border=\"1\">\n" +
                    "<tr>\n" +
                    "<th>ID</th>\n" +
                    "<th>姓名</th>\n" +
                    "<th>电话号码</th>\n"+
                    "<th>住址</th>\n"+
                    "</tr>";
            document.getElementById("demost").innerHTML=s1;
            $.each(data, function (i, item) {
              s+=item.location+" ";
            });
            alert(s)
          }
        });
        // $.ajax({
        //   // 编写json格式，设置属性和值
        //   url:"hel/flist",
        //   contentType:"application/json;charset=UTF-8",
        //   //data:'{"name":"hehe","age":18}',
        //   data:{Id:Id,name:name,number:number,location:location},
        //   dataType:"json",
        //   type:"post",
        //
        //   success:function(data){
        //     // data服务器端响应的json的数据，进行解析
        //    var s ="";
        //    for (var m in data){
        //      alert("执行了")
        //      alert(data.toString());
        //      s+="<option value='"+data[i].location+"'>"+data[i].name+"</option>"
        //    }
        //     $("#firstJob").html(s);
        //
        //     $('#firstJob').selectpicker("refresh");
        //   },error:function(data){
        //
        //     $.messager.alert('出错了','系统出错，请联系管理员。','error');
        //
        //   }
        // });

      });
    });
  </script>

  <table id="t1a" border="1">
<%--    <tr>--%>
<%--      <th>Heading</th>--%>
<%--      <th>Another Heading</th>--%>
<%--    </tr>--%>
  <tr>
    <td align="center">row 1, cell 1</td>
    <td align="center">row 1, cell 2</td>
  </tr>
  <tr>
    <td align="center">row 2, cell 1</td>
    <td align="center">row 2, cell 2</td>
  </tr>
  </table><br>



  <script>
    function getCellValue(taname) {
      // alert("y");
      alert("y");
      var obj = document.getElementById(taname);
      //for(var i=0;i<obj.rows.length;i++)
      alert(obj.rows.length)//ta拿到了obj貌似可以设置onclick
      alert(obj.rows[0].cells.length)


      alert(obj.rows[1].cells[0].innerText);//显示第2行，第1列的内容
    }
    function getCellValue1() {
      alert("wwww")
      var obj = document.getElementById("ta1");
      //for(var i=0;i<obj.rows.length;i++)
      alert(obj.rows.length)
      alert(obj.rows(1).cells(0).value());//显示第2行，第1列的内容
    }


  </script>

  <button id="bl" onclick=getCellValue('ta')>得到ta表格数据，进一步设置修改</button><br>
  <button id="b2" onclick=getCellValue("demost1")>得到demost2表格数据，进一步设置修改</button><br>
  <button id="b3"  onclick=getCellValue1()>得到ta表格数据，进一步设置修改</button><br>
  <button id="b4"  onclick=getCellValue("t1a")>得到t1a表格数据，进一步设置修改</button><br>


  </body>
</html>
