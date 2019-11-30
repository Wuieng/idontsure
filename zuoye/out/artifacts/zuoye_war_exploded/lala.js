function getCellValue1() {
    alert("wwww")
    var obj = document.getElementById("ta");
    //for(var i=0;i<obj.rows.length;i++)
    alert(obj.rows.length)
    alert(obj.rows(1).cells(0).innerText);//显示第2行，第1列的内容
}
function getCellValue(taname) {
    // alert("y");
    var obj = document.getElementById(taname);
    //for(var i=0;i<obj.rows.length;i++)
    alert(obj.rows.length)//ta拿到了obj貌似可以设置onclick
    alert(obj.rows[0].cells.length)
    //demost是div拿不到属性
    alert(obj.rows(0).cells(0).innerText);
    alert(obj.rows[0].cells[0].innerText);//显示第2行，第1列的内容
}