package hkmu.wadd.pj.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
    public String showMaterialDetails(@PathVariable int lectureId, Model model) {
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

    @GetMapping("/editMaterial")
    public String editMaterial(Model model) {
        model.addAttribute("lectures", lectures);
        return "editMaterial";
    }
    @PostMapping("/editMaterial/removeLecture")
    public String removeLecture(@ModelAttribute int lectureId) {
        System.out.println(lectureId);
        lectures.remove(lectureId);
        return "editMaterial";
    }
    /*@PostMapping("/editMaterial/{lectureId}")
    public String editMaterial(@PathVariable int lectureId) {
        lectures.remove(lectureId);
        return "redirect:/editMaterial";
    }*/
    @PostMapping("/editMaterial/addLecture")
    public String addLecture(@RequestParam("lectureId") int id, @RequestParam("lectureTitle") String title) {
        lectures.put(id, title);
        return "editMaterial";
    }
    /*@PostMapping("/addLecture")
    public String addLecture(@RequestParam("lectureId") int id, @RequestParam("lectureTitle") String title) {
        lectures.put(id, title);
        return "redirect:/lectures";
    }*/

    @GetMapping("/editPolling")
    public String editPolling(Model model) {
        model.addAttribute("mcQuestions", mcQuestions);
        return "editPolling";
    }

    @GetMapping("/list")
    public String list() {
        return "list";
    }

}