package hkmu.wadd.pj.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class McController {
    private final String[] mcQuestions = {
            "What is your favourite University?",
            "How you rate your Ulife in HKMU?",
            "Which public transport you prefer to take to school?",
            "What facilities you want to have in HKMU?",
            "How old are you?"
    };

    private final String[][] mcOptions = {
            {"MU", "MUHK", "Metropolitan University", "HKMU"},
            {"Very Excellent", "Excellent", "Good", "Very Good"},
            {"MTR", "Bus", "Minibus", "Walking"},
            {"Library", "Gym", "Study Room", "Sports Facility"},
            {"Under 18", "18-20", "21-23", "Over 24"}
    };

    private int[][] votes = new int[5][4];

    @GetMapping("/mc")
    public String showPolls(Model model) {
        model.addAttribute("questions", mcQuestions);
        model.addAttribute("options", mcOptions);
        model.addAttribute("votes", votes);
        return "mc";
    }
    @GetMapping("/mc1")
    public String mc1(Model model) {
        model.addAttribute("questions", mcQuestions);
        model.addAttribute("options", mcOptions);
        model.addAttribute("votes", votes);
        return "mc1";
    }

    @PostMapping("/mc/vote")
    public String handleVote(
            @RequestParam(value ="questionId", required = false) int questionId,
            @RequestParam(value ="optionId", required = false) int optionId,
            Model model, HttpServletRequest request) {

        try{

            if (questionId >= 0 && questionId < votes.length &&
                    optionId >= 0 && optionId < votes[questionId].length) {
                votes[questionId][optionId]++;
            }else {
                throw new IllegalArgumentException("Invalid question or option ID");
            }

            model.addAttribute("selectedOption", mcOptions[questionId][optionId]);
            model.addAttribute("question", mcQuestions[questionId]);
            return "votesuccess";
        }catch(Exception e) {
            request.setAttribute("error", e.getMessage());
            return "mcerror";
        }
    }
    @PostMapping("/mc1/vote")
    public String handleVote1(
            @RequestParam(value = "questionId") int questionId,
            @RequestParam(value = "optionId") String optionId, // Assuming optionId corresponds to the value of the selected option
            Model model) {

        // Assuming you have a list of questions and options
        String selectedQuestion = mcQuestions[questionId]; // Get the selected question
        String selectedOption = optionId; // The selected answer from the form

        // Store the results in the model
        model.addAttribute("selectedQuestion", selectedQuestion);
        model.addAttribute("selectedOption", selectedOption);

        // Redirect to the success page
        return "votesuccess"; // The name of the JSP page to show success
    }

}

