package cdsd.dao;

import cdsd.domain.Man;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ManDao {
//    因为这个项目是让我实现简单的通讯录功能，所以我不打算写什么判断为空之类的
    @Select("select * from txun")
    public List<Man> find();
    //    前后地数据库中地属性ID是大写，不过貌似数据库也不区分大小写，在domain里的man属性是Id
    @Insert("INSERT INTO noda.txun(ID, name, number,location)VALUES (#{Id},#{name},#{number},#{location})")
    public void save(Man man);

    @Delete("DELETE FROM noda.txun WHERE ID=#{param0}")
    public void delete(String Id);

    @Update("update noda.txun set ID=#{Id},name=#{name},number=#{number},location=#{location} where ID=#{Id}")
    public void xiu(Man man);
}
