package cdsd.service;

import cdsd.domain.Man;

import java.util.List;

public interface UserService {
    public List<Man> find();
    public void save(Man man);
    public void change(Man man);
    public void delete(String Id);
}
