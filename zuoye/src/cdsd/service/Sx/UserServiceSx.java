package cdsd.service.Sx;

import cdsd.dao.ManDao;
import cdsd.domain.Man;
import cdsd.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("UserService")
public class UserServiceSx implements UserService {

    @Autowired
    private ManDao manDao;
    @Override
    public List<Man> find() {
        System.out.println("查询所有通讯录的人");
        return manDao.find();
    }
    @Override
    //是否返回list返回值，看之后是否方便
    public void save(Man man) {
        System.out.println("保存一份数据");
        manDao.save(man);
        //考虑修改返回值，暂时先不修改返回值
    }
    @Override
    public void change(Man man) {
        System.out.println("修改通讯录里的数据");
        manDao.xiu(man);
        //考虑修改返回值，暂时先不修改返回值
    }

    @Override
    public void delete(String Id) {
        manDao.delete(Id);
    }
}
