package hkmu.wadd.pj.model;

import java.util.Date;

public class CommentMaterial {
    private Integer id;
    private Integer materialId;
    private String name;
    private String message;
    private Date date;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getMaterialId() { return materialId; }
    public void setMaterialId(Integer materialId) { this.materialId = materialId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }
}