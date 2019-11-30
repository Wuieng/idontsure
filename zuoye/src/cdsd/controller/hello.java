package cdsd.controller;


import cdsd.domain.Man;
import cdsd.domain.User;
import cdsd.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/hel")
public class hello {
//    我想要在另外一个类中写另外的控制器。

    //尝试整合mvc
    //如果这里不写自动注入，会成功吗？也许也会
    //答案是并不会
    @Autowired
    private UserService userservice;
//得到所有的数据
    @RequestMapping("/getrequ")
    public void getrequ(@RequestBody User user){
        System.out.println("执行了封装");
        System.out.println(user.getAge());
        List<Man> a = userservice.find();//如果执行成功会在这里显示查询所有通。。
        System.out.println(a.isEmpty());
        //后面发现成功了
        for (Man i : a){
            System.out.println(i.getName());
        }

    }
//    测试得到封装的数据
    @RequestMapping("/getreqback")
    public @ResponseBody User getreqback(@RequestBody User user){
        System.out.println("执行了封装,并且异步处理");
        user.setAge(77);
        return  user;
    }
//    测试直接拿到字符串
    @RequestMapping("/aj")
    public void sayhello(@RequestBody String body){
        System.out.println("执行了body");
        System.out.println(body);
    }
//   用于测试ajax能不能读取List,并且测试是否这个注解可以传list

    //下面的函数用于刷新，查询，可以不要user，之后在说，
//    对实际使用，我是传了一个空值
    @RequestMapping("/flist")
    @ResponseBody
    public  List<Man> getList(@RequestBody Man man){
        System.out.println(man.getName());
        return userservice.find();
    }
//    下面是删除函数
@RequestMapping("/delete")
@ResponseBody
public  String delete(@RequestBody String Id){
        userservice.delete(Id);
    return "/biaoge.jsp";

}
    //查询函数
    @RequestMapping("/cha")
    @ResponseBody
    public  List<Man> cha(@RequestBody String body){
        System.out.println(body);
        List<Man> all = userservice.find();
        List<Man> ca= new ArrayList<>();
        for(Man i : all){
            if (i.getName().contains(body)){
                ca.add(i);
            }
        }
        return ca;
    }
//    修改函数,成功但是原来的那种无返回值的类型失败，有时间了解其原理
@RequestMapping("/chan")
@ResponseBody
public  String chan(@RequestBody Man man){

    System.out.println(man.toString());
    userservice.change(man);
    return "/biaoge.jsp";

}
//下面是添加函数，用于insert数据，仿照添加写写看
@RequestMapping("/tian")
@ResponseBody
public  String tian(@RequestBody Man man){

    System.out.println(man.toString());
    userservice.save(man);
    return "/biaoge.jsp";

}


//    下面是跳转界面重定向相关的
    @RequestMapping("/hi")
    public String sayhi(){
        System.out.println("跳转了");
        return "success";
    }

    @RequestMapping("/zou")
    public String zou(){
        System.out.println("跳转了修改添加页面");
        return "yy";
    }

    @RequestMapping("/biao")
    public String say(){
        System.out.println("跳转了");
        return "/biaoge.jsp";
        //被当做静态页面了
    }


}
