package hkmu.wadd.pj.model;

import java.util.Date;

public class Vote {
    private String userName;
    private Integer pollingId;
    private String question;
    private String option;
    private Date date;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Integer getPollingId() {
        return pollingId;
    }

    public void setPollingId(Integer pollingId) {
        this.pollingId = pollingId;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getOption() {
        return option;
    }

    public void setOption(String option) {
        this.option = option;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
