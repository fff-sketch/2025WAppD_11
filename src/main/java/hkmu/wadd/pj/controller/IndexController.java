package hkmu.wadd.pj.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Controller
public class IndexController {
    private final Map<Integer, String> lectures = new ConcurrentHashMap<>();
    private final Map<Integer, String> mcQuestions = new ConcurrentHashMap<>();
    private final Map<Integer, String[]> mcOptions = new ConcurrentHashMap<>();

    public IndexController() {
        this.lectures.put(1, "HelloWorld");
        this.lectures.put(2, "ByeWorld");
        this.lectures.put(3, "Login/Logout");
        this.lectures.put(4, "2nd last Lecture");
        this.lectures.put(5, "Last Lecture");

        this.mcQuestions.put(1, "What is your favourite University?");
        this.mcQuestions.put(2, "How you rate your Ulife in HKMU?");
        this.mcQuestions.put(3, "Which public transport you prefer to take to school?");
        this.mcQuestions.put(4, "What facilities you want to have in HKMU?");
        this.mcQuestions.put(5, "How old are you?");

        this.mcOptions.put(1, new String[]{"MU", "MUHK", "Metropolitan University", "HKMU"});
        this.mcOptions.put(2, new String[]{"Very Excellent", "Excellent", "Good", "Very Good"});
        this.mcOptions.put(3, new String[]{"MTR", "Bus", "Minibus", "Walking"});
        this.mcOptions.put(4, new String[]{"Library", "Gym", "Study Room", "Sports Facility"});
        this.mcOptions.put(5, new String[]{"Under 18", "18-20", "21-23", "Over 24"});
    }

    @GetMapping({"/", "/index"})
    public String index(Model model) {
        model.addAttribute("lectures", lectures);
        model.addAttribute("mcQuestions", mcQuestions);
        return "index";
    }

    @GetMapping("/lectures/{lectureId}")
    public String showLectureDetails(@PathVariable int lectureId, Model model) {
        String lectureTitle = lectures.get(lectureId);
        model.addAttribute("lectureId", lectureId);
        model.addAttribute("lectureTitle", lectureTitle);
        return "lecture";
    }

    @GetMapping("/mc/{mcId}")
    public String showPollDetails(@PathVariable int mcId, Model model) {
        String question = mcQuestions.get(mcId);
        String[] options = mcOptions.get(mcId);
        model.addAttribute("mcId", mcId);
        model.addAttribute("question", question);
        model.addAttribute("options", options);
        return "mc";
    }

    @GetMapping("/list")
    public String list() {
        return "list";
    }

}