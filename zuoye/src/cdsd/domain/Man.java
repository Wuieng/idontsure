package cdsd.domain;

import java.io.Serializable;

public class Man implements Serializable {
    private String Id;
    private String name;
    private String number;
    private String location;

    public String getId() {
        return Id;
    }

    public void setId(String id) {
        Id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    @Override
    public String toString() {
        return "Man{" +
                "Id='" + Id + '\'' +
                ", name='" + name + '\'' +
                ", number='" + number + '\'' +
                ", location='" + location + '\'' +
                '}';
    }
}
