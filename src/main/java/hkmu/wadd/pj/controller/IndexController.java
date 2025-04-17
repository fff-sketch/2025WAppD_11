package hkmu.wadd.pj.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Controller
public class IndexController {
    private volatile int commentIdSequence = 1;
    private final Map<Integer, comment> entries = new ConcurrentHashMap<>();
    private final Map<Integer, String> lectures = new ConcurrentHashMap<>();
    private final Map<Integer, String> mcQuestions = new ConcurrentHashMap<>();
    private final Map<Integer, String[]> mcOptions = new ConcurrentHashMap<>();
    private int[][] votes = new int[5][4];

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

    private synchronized int getNextCommentId() {
        return this.commentIdSequence++;
    }

    @GetMapping({"/", "/index"})
    public String index(Model model) {
        model.addAttribute("lectures", lectures);
        model.addAttribute("mcQuestions", mcQuestions);
        model.addAttribute("entries", entries.values());
        return "index";
    }

    @GetMapping("/lectures/{lectureId}")
    public String showLectureDetails(@PathVariable int lectureId, Model model) {
        String lectureTitle = lectures.get(lectureId);
        model.addAttribute("lectureId", lectureId);
        model.addAttribute("lectureTitle", lectureTitle);
        return "lecture";
    }
    @GetMapping("/lectures/{lectureId}/addComment")
    public ModelAndView addCommentForm() {
        return new ModelAndView("addComment", "entry", new comment());
    }
    @PostMapping("/lectures/{lectureId}/addComment")
    public View addCommentHandle(@ModelAttribute("entry") comment c) {
        Integer id = getNextCommentId();
        c.setId(id);
        c.setDate(new Date());
        this.entries.put(id, c);
        return new RedirectView("."); // One way to redirect in Spring MVC
    }

    @GetMapping("/mc/{mcId}")
    public String showPollDetails(@PathVariable int mcId, Model model) {
        String question = mcQuestions.get(mcId);
        String[] options = mcOptions.get(mcId);
        model.addAttribute("mcId", mcId);
        model.addAttribute("question", question);
        model.addAttribute("options", options);
        model.addAttribute("votes", votes);
        return "mc";
    }
    @PostMapping("/mc/{mcId}/vote")
    public String handleVote(
            @RequestParam(value = "questionId") int questionId,
            @RequestParam(value = "optionId") int optionId,
            Model model, HttpServletRequest request) {

        try {
            if (questionId < 1 || questionId > votes.length ||
                    optionId < 0 || optionId >= votes[questionId - 1].length) {
                throw new IllegalArgumentException("Invalid question or option ID");
            }

            votes[questionId - 1][optionId]++;
            //model.addAttribute("mcId", questionId);
            model.addAttribute("selectedQuestion", mcQuestions.get(questionId)); // Changed to match votesuccess.jsp
            model.addAttribute("selectedOption", mcOptions.get(questionId)[optionId]);
            return "votesuccess";
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            return "mcerror";
        }
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

    /*@GetMapping("/addComment")
    public ModelAndView addCommentForm() {
        return new ModelAndView("addComment", "entry", new comment());
    }
    @PostMapping("/addComment")
    public View addCommentHandle(@ModelAttribute("entry") comment c) {
        Integer id = getNextCommentId();
        c.setId(id);
        c.setDate(new Date());
        this.entries.put(id, c);
        return new RedirectView("."); // One way to redirect in Spring MVC
    }*/

    @GetMapping("/list")
    public String list() {
        return "list";
    }
}