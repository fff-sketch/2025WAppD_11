package hkmu.wadd.pj.model;

import java.util.Date;

public class CommentPolling {
    private Integer id;
    private String name;
    private String message;
    private Date date;
    private Integer pollingId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public void setPollingId(int pollingId) {
        this.pollingId = pollingId;
    }

    public int getPollingId() {
        return pollingId;
    }
}
