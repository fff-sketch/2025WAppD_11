package hkmu.wadd.pj.controller;

import hkmu.wadd.pj.model.*;
import hkmu.wadd.pj.repository.FileService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Controller
public class IndexController {
    private volatile int commentIdSequence = 1;
    private volatile int voteIdSequence = 1;
    private int materialTableIndex = 0;
    private int pollingTableIndex = 0;

    private final Map<Integer, CommentMaterial> mComments = new ConcurrentHashMap<>();
    private final Map<Integer, CommentPolling> pComments = new ConcurrentHashMap<>();
    private final Map<Integer, Material> materials = new ConcurrentHashMap<>();
    private final Map<Integer, Polling> pollings = new ConcurrentHashMap<>();
    private final Map<Integer, Vote> votes = new ConcurrentHashMap<>();

    private final String[] materialData = {"Overview of Web Applications", "Servlet", "JSP, JavaBean", "Session", "EL, JSTL, Custom tag"};
    private final String[] mcQuestionData = {"What is your favourite University?", "How you rate your Ulife in HKMU?", "Which public transport you prefer to take to school?", "What facilities you want to have in HKMU?", "How old are you?"};
    private final String[][] mcOptionData = {{"MU", "MUHK", "Metropolitan University", "HKMU"}, {"Very Excellent", "Excellent", "Good", "Very Good"}, {"MTR", "Bus", "Minibus", "Walking"}, {"Library", "Gym", "Study Room", "Sports Facility"}, {"Under 18", "18-20", "21-23", "Over 24"}};

    @Autowired
    private FileService fileService;

    public IndexController() {
        for (int i = 0; i < 5; i++) {
            Integer id = i + 1;
            Material material = new Material();
            material.setLectureId(id);
            material.setLectureTitle(materialData[i]);
            materials.put(id, material);
        }
        for (int i = 0; i < 5; i++) {
            Integer id = i + 1;
            Polling polling = new Polling();
            polling.setPollingId(id);
            polling.setQuestion(mcQuestionData[i]);
            polling.setOption(mcOptionData[i]);
            pollings.put(id, polling);
        }
    }

    private synchronized int getNextCommentId() {
        return this.commentIdSequence++;
    }
    private synchronized int getNextVoteId() {
        return this.voteIdSequence++;
    }

    @PostMapping("/upload")
    public String upload(@RequestParam("file") MultipartFile[] file) {
        for (MultipartFile fileItem : file) {
            fileService.saveFile(fileItem);
        }
        return "redirect:/index";
    }

    @GetMapping("/download/{fileId}")
    public ResponseEntity<ByteArrayResource> download(@PathVariable int fileId) {
        LectureFile file = fileService.getLectureFileById(fileId).get();
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(file.getFileType()))
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment:filename=\""+file.getFileName()+"\"")
                .body(new ByteArrayResource(file.getData()));
    }

    @GetMapping({"/", "/index"})
    public String index(Model model) {
        model.addAttribute("materials", materials.values());
        model.addAttribute("pollings", pollings.values());
        List<LectureFile> files = fileService.getFiles();
        model.addAttribute("files", files);
        return "index";
    }

    @GetMapping("/materials/{materialId}")
    public String showMaterialDetails(@PathVariable int materialId, Model model) {
        model.addAttribute("materialId", materials.get(materialId).getLectureId());
        model.addAttribute("materialTitle", materials.get(materialId).getLectureTitle());
        model.addAttribute("mComments", mComments.values());
        model.addAttribute("index",materialTableIndex);
        return "material";
    }
    @GetMapping("/materials/{materialId}/addMComment/{currentUser}")
    public ModelAndView addCommentForm(@PathVariable int materialId, @PathVariable String currentUser) {
        ModelAndView modelAndView = new ModelAndView("addMComment");
        modelAndView.addObject("mCmEntry", new CommentMaterial());
        modelAndView.addObject("materialId", materialId); // Pass materialId to the form
        modelAndView.addObject("currentUser", currentUser);
        return modelAndView;
    }
    @PostMapping("/materials/{materialId}/addMComment/{currentUser}")
    public RedirectView addCommentHandle(
            @PathVariable int materialId,
            @ModelAttribute("mCmEntry") CommentMaterial commentM
    ) {
        Integer id = getNextCommentId();
        commentM.setId(id);
        commentM.setDate(new Date());
        //commentM.setLectureId(materialId); // Associate commentM with the lecture
        this.mComments.put(id, commentM);
        return new RedirectView("/pj/materials/" + materialId); // Redirect back to the lecture
    }

    @GetMapping("/polling/{pollingId}")
    public String showPollDetails(@PathVariable int pollingId, Model model) {
        String question = pollings.get(pollingId).getQuestion();
        String[] options = pollings.get(pollingId).getOption();
        int[] voteCount = pollings.get(pollingId).getVoteCount();
        model.addAttribute("pollingId", pollingId);
        model.addAttribute("question", question);
        model.addAttribute("options", options);
        model.addAttribute("voteCount", voteCount);
        model.addAttribute("pComments", pComments.values());
        model.addAttribute("index",pollingTableIndex);
        return "polling";
    }
    @PostMapping("/polling/{pollingId}/vote/{currentUser}")
    public String handleVote(
            @PathVariable String currentUser,
            @RequestParam(value = "questionId") int questionId,
            @RequestParam(value = "optionId") int optionId,
            Model model, HttpServletRequest request) {
        try {
            int[] voteCount = pollings.get(questionId).getVoteCount();
            if (questionId < 1 || questionId > pollings.size() ||
                    optionId < 0 || optionId >= voteCount.length) {
                throw new IllegalArgumentException("Invalid question or option ID");
            }
            voteCount[optionId]++;

            Integer id = getNextVoteId();
            Vote vote = new Vote();
            vote.setUserName(currentUser);
            vote.setPollingId(questionId);
            vote.setQuestion(pollings.get(questionId).getQuestion());
            vote.setOption(pollings.get(questionId).getOption()[optionId]);
            vote.setDate(new Date());
            votes.put(id, vote);
            System.out.println(vote.getQuestion());
            System.out.println(vote.getOption());
            System.out.println(vote.getPollingId());
            System.out.println(vote.getUserName());
            System.out.println(vote.getDate());

            model.addAttribute("selectedQuestion", pollings.get(questionId).getQuestion()); // Changed to match voteSuccess.jsp
            model.addAttribute("selectedOption", pollings.get(questionId).getOption()[optionId]);
            return "voteSuccess";
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            return "voteError";
        }
    }
    @GetMapping("/polling/{pollingId}/addPComment/{currentUser}")
    public ModelAndView addCommentForm2(@PathVariable int pollingId, @PathVariable String currentUser) {
        ModelAndView modelAndView = new ModelAndView("addPComment");
        modelAndView.addObject("pCmEntry", new CommentPolling());
        modelAndView.addObject("pollingId", pollingId); // Pass pollingId to the form
        modelAndView.addObject("currentUser", currentUser);
        return modelAndView;
    }
    @PostMapping("/polling/{pollingId}/addPComment/{currentUser}")
    public RedirectView addCommentHandle2(
            @PathVariable int pollingId,
            @ModelAttribute("pCmEntry") CommentPolling commentP
    ) {
        Integer id = getNextCommentId();
        commentP.setId(id);
        commentP.setDate(new Date());
        this.pComments.put(id, commentP);
        return new RedirectView("/pj/polling/" + pollingId); // Redirect back to the lecture
    }

    @GetMapping("/editMaterial")
    public String editMaterial(Model model) {
        model.addAttribute("materials", materials.values());
        List<CommentMaterial> mcommentsList = new ArrayList<>(mComments.values());
        model.addAttribute("mcomments", mcommentsList);
        int index = 0;
        model.addAttribute("index",index);
        return "editMaterial";
    }
    @GetMapping("/editMaterial/addLecture")
    public ModelAndView addLectureForm() {
        ModelAndView modelAndView = new ModelAndView("addLecture");
        modelAndView.addObject("adLEntry", new Material());
        return modelAndView;
    }
    @PostMapping("/editMaterial/addLecture")
    public RedirectView addLectureHandle(
            @ModelAttribute("adLEntry") Material material
    ) {
        Integer id = material.getLectureId();
        this.materials.put(id, material);
        return new RedirectView("/pj/editMaterial");
    }
    @GetMapping("/editMaterial/removeLecture/{id}")
    public RedirectView removeLecture(@PathVariable Integer id) {
        materials.remove(id);
        return new RedirectView("/pj/editMaterial");
    }
    @GetMapping("/editMaterial/deleteMaterialComment/{id}")
    public RedirectView deleteMaterialComment(@PathVariable Integer id) {
        mComments.remove(id);
        return new RedirectView("/pj/editMaterial");
    }

    @GetMapping("/editPolling")
    public String editPolling(Model model) {
        model.addAttribute("pollings", pollings.values());
        List<CommentPolling> pcommentsList = new ArrayList<>(pComments.values());
        model.addAttribute("pcomments", pcommentsList);
        int index = 0;
        model.addAttribute("index",index);
        return "editPolling";
    }
    @GetMapping("/editPolling/addPolling")
    public ModelAndView addPollingForm() {
        ModelAndView modelAndView = new ModelAndView("addPolling");
        modelAndView.addObject("adPEntry", new Polling());
        return modelAndView;
    }
    @PostMapping("/editPolling/addPolling")
    public RedirectView addPollingHandle(
            @ModelAttribute("adPEntry") Polling polling
    ) {
        Integer id = polling.getPollingId();
        polling.packOptions();
        this.pollings.put(id, polling);
        return new RedirectView("/pj/editPolling");
    }
    @GetMapping("/editPolling/removePolling/{id}")
    public RedirectView removePolling(@PathVariable Integer id) {
        pollings.remove(id);
        return new RedirectView("/pj/editPolling");
    }
    @GetMapping("/editPolling/deletePollingComment/{id}")
    public RedirectView deletePollingComment(@PathVariable Integer id) {
        pComments.remove(id);
        return new RedirectView("/pj/editPolling");
    }

    @GetMapping({"/commentHistory/{currentUser}"})
    public String showCommentHistory(@PathVariable String currentUser, Model model) {
        List<CommentMaterial> mcommentsList = new ArrayList<>(mComments.values());
        List<CommentPolling> pcommentsList = new ArrayList<>(pComments.values());
        model.addAttribute("mComments", mcommentsList);
        model.addAttribute("pComments", pcommentsList);
        model.addAttribute("currentUser", currentUser);
        int mindex = 0;
        model.addAttribute("mindex",mindex);
        int pindex = 0;
        model.addAttribute("pindex",pindex);
        return "commentHistory";
    }

    @GetMapping({"/votingHistory/{currentUser}"})
    public String showVotingHistory(Model model) {
        model.addAttribute("votes", votes.values());
        return "votingHistory";
    }

    @GetMapping("/loginNotice")
    public String noticeToLogin() {
        return "loginNotice";
    }
}