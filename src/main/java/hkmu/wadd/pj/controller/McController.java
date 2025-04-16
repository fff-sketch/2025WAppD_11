package hkmu.wadd.pj.controller;

import org.springframework.stereotype.Controller;

@Controller
public class McController {
    /*private final String[] mcQuestions = {
            "What is your favourite University?",
            "How you rate your Ulife in HKMU?",
            "Which public transport you prefer to take to school?",
            "What facilities you want to have in HKMU?",
            "How old are you?",
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
    }*/

}

