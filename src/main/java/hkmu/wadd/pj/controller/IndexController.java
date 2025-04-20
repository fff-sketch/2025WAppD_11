package hkmu.wadd.pj.controller;

import hkmu.wadd.pj.FileRepository;
import hkmu.wadd.pj.model.CommentMaterial;
import hkmu.wadd.pj.model.CommentPolling;

import hkmu.wadd.pj.model.FileEntity;
import jakarta.servlet.http.HttpServletRequest;

import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;


@Controller
public class IndexController {
    private volatile int commentIdSequence = 1;
    private int materialTableIndex = 0;
    private int pollingTableIndex = 0;
    //private final Map<Integer, CommentMaterial> entries = new ConcurrentHashMap<>();
    private final Map<Integer, CommentMaterial> mComments = new ConcurrentHashMap<>();
    private final Map<Integer, CommentPolling> pComments = new ConcurrentHashMap<>();
    private final Map<Integer, String> materials = new ConcurrentHashMap<>();
    private final Map<Integer, String> mcQuestions = new ConcurrentHashMap<>();
    private final Map<Integer, String[]> mcOptions = new ConcurrentHashMap<>();
    private int[][] votes = new int[5][4];

    @Autowired
    private FileRepository fileRepository;
    public IndexController() {
        this.materials.put(1, "HelloWorld");
        this.materials.put(2, "ByeWorld");
        this.materials.put(3, "Login/Logout");
        this.materials.put(4, "2nd last Lecture");
        this.materials.put(5, "Last Lecture");

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
        model.addAttribute("materials", materials);
        model.addAttribute("mcQuestions", mcQuestions);
        return "index";
    }

    @GetMapping("/materials/{materialId}")
    public String showMaterialDetails(@PathVariable int materialId, Model model) {
        String materialTitle = materials.get(materialId);
        List<FileEntity> files = fileRepository.findByMaterialId(materialId);
        model.addAttribute("files", files);
        model.addAttribute("materialId", materialId);
        model.addAttribute("materialTitle", materialTitle);
        model.addAttribute("mComments", mComments.values());
        model.addAttribute("mindex",materialTableIndex);
        return "material";
    }
    @GetMapping("/materials/{materialId}/addMComment")
    public ModelAndView addCommentForm(@PathVariable int materialId) {
        ModelAndView modelAndView = new ModelAndView("addMComment");
        modelAndView.addObject("mCmEntry", new CommentMaterial()); // Ensure 'Comment' is capitalized (Java convention)
        modelAndView.addObject("materialId", materialId); // Pass materialId to the form
        return modelAndView;
    }
    @PostMapping("/materials/{materialId}/addMComment")
    public RedirectView addCommentHandle(
            @PathVariable int materialId,
            @ModelAttribute("mCmEntry") CommentMaterial comment
    ) {
        Integer id = getNextCommentId();
        comment.setId(id);
        comment.setDate(new Date());
        //comment.setLectureId(materialId); // Associate comment with the lecture
        this.mComments.put(id, comment);
        System.out.println("Comment added: " + comment);
        System.out.println("mComments put: " + mComments);
        return new RedirectView("/pj/materials/" + materialId); // Redirect back to the lecture
    }
    /*backup*/
    /*@GetMapping("/materials/{materialId}/addMComment")
    public ModelAndView addCommentForm() {
        return new ModelAndView("addMComment", "mCmEntry", new Comment());
    }
    @PostMapping("/materials/{materialId}/addMComment")
    public View addCommentHandle(@ModelAttribute("mCmEntry") Comment c) {
        Integer id = getNextCommentId();
        c.setId(id);
        c.setDate(new Date());
        this.entries.put(id, c);
        return new RedirectView("."); // One way to redirect in Spring MVC
    }*/

    @PostMapping("/materials/{materialId}/upload")
    public String handleFileUpload(
            @PathVariable int materialId,
            @RequestParam("file") MultipartFile file,
            Model model
    ) {
        String materialTitle = materials.get(materialId);
        if (file.isEmpty()) {
            model.addAttribute("uploadError", "Please select a file to upload.");
        } else {
            try {
                FileEntity fileEntity = new FileEntity();
                fileEntity.setMaterialId(materialId);
                fileEntity.setFileName(file.getOriginalFilename());
                fileEntity.setContent(file.getBytes());
                fileEntity.setUploadDate(new Date());
                fileRepository.save(fileEntity);
                model.addAttribute("uploadMessage", "File uploaded successfully: " + file.getOriginalFilename());
            } catch (IOException e) {
                model.addAttribute("uploadError", "Failed to upload file: " + e.getMessage());
            }
        }

        // Refresh page attributes
        model.addAttribute("materialId", materialId);
        model.addAttribute("materialTitle", materialTitle);
        model.addAttribute("mComments", mComments.values());
        model.addAttribute("mindex", materialTableIndex);
        model.addAttribute("files", fileRepository.findByMaterialId(materialId));
        return "material";
    }

    @GetMapping("/materials/{materialId}/download/{fileId}")
    public void downloadFile(
            @PathVariable int materialId,
            @PathVariable Long fileId,
            HttpServletResponse response
    ) throws IOException {
        FileEntity fileEntity = fileRepository.findById(fileId)
                .orElseThrow(() -> new IllegalArgumentException("File not found"));

        // Set response headers
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileEntity.getFileName() + "\"");

        // Write file content to response
        response.getOutputStream().write(fileEntity.getContent());
    }


    @GetMapping("/polling/{pollingId}")
    public String showPollDetails(@PathVariable int pollingId, Model model) {
        String question = mcQuestions.get(pollingId);
        String[] options = mcOptions.get(pollingId);
        model.addAttribute("pollingId", pollingId);
        model.addAttribute("question", question);
        model.addAttribute("options", options);
        model.addAttribute("votes", votes);
        model.addAttribute("pComments", pComments.values());
        model.addAttribute("pindex",pollingTableIndex);
        return "polling";
    }
    @PostMapping("/polling/{pollingId}/vote")
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
            model.addAttribute("selectedQuestion", mcQuestions.get(questionId)); // Changed to match voteSuccess.jsp
            model.addAttribute("selectedOption", mcOptions.get(questionId)[optionId]);
            return "voteSuccess";
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            return "voteError";
        }
    }
    @GetMapping("/polling/{pollingId}/addPComment")
    public ModelAndView addCommentForm2(@PathVariable int pollingId) {
        ModelAndView modelAndView = new ModelAndView("addPComment");
        modelAndView.addObject("pCmEntry", new CommentPolling()); // Ensure 'Comment' is capitalized (Java convention)
        modelAndView.addObject("pollingId", pollingId); // Pass pollingId to the form
        return modelAndView;
    }
    @PostMapping("/polling/{pollingId}/addPComment")
    public RedirectView addCommentHandle2(
            @PathVariable int pollingId,
            @ModelAttribute("pCmEntry") CommentPolling comment
    ) {
        Integer id = getNextCommentId();
        comment.setId(id);
        comment.setDate(new Date());
        //comment.setLectureId(pollingId); // Associate comment with the lecture
        this.pComments.put(id, comment);
        System.out.println("Comment added: " + comment);
        System.out.println("pComments put: " + pComments);
        return new RedirectView("/pj/polling/" + pollingId); // Redirect back to the lecture
    }

    @GetMapping("/editMaterial")
    public String editMaterial(Model model) {
        model.addAttribute("materials", materials);
        return "editMaterial";
    }
    @GetMapping("/editMaterial/addLecture")
    public String addLecture_get(@RequestParam("materialId") int id, @RequestParam("materialTitle") String title) {
        materials.put(id, title);
        return "editMaterial";
    }
    @PostMapping("/editMaterial/addLecture")
    public RedirectView addLecture_post(@RequestParam("materialId") int id, @RequestParam("materialTitle") String title) {
        materials.put(id, title);
        return new RedirectView("/pj/editMaterial");
    }
    @PostMapping("/editMaterial/removeLecture")
    public String removeLecture(@ModelAttribute int materialId) {
        System.out.println(materialId);
        materials.remove(materialId);
        return "editMaterial";
    }
    /*public ModelAndView addCommentForm(@PathVariable int materialId) {
        ModelAndView modelAndView = new ModelAndView("addMComment");
        modelAndView.addObject("mCmEntry", new CommentMaterial()); // Ensure 'Comment' is capitalized (Java convention)
        modelAndView.addObject("materialId", materialId); // Pass materialId to the form
        return modelAndView;
    }
    @PostMapping("/materials/{materialId}/addMComment")
    public RedirectView addCommentHandle(
            @PathVariable int materialId,
            @ModelAttribute("mCmEntry") CommentMaterial comment
    ) {
        Integer id = getNextCommentId();
        comment.setId(id);
        comment.setDate(new Date());
        //comment.setLectureId(materialId); // Associate comment with the lecture
        this.mComments.put(id, comment);
        System.out.println("Comment added: " + comment);
        System.out.println("mComments put: " + mComments);
        return new RedirectView("/pj/materials/" + materialId); // Redirect back to the lecture
    }*/
    /*@PostMapping("/editMaterial/{materialId}")
    public String editMaterial(@PathVariable int materialId) {
        materials.remove(materialId);
        return "redirect:/editMaterial";
    }*/
    /*@PostMapping("/addLecture")
    public String addLecture(@RequestParam("materialId") int id, @RequestParam("materialTitle") String title) {
        materials.put(id, title);
        return "redirect:/materials";
    }*/

    @GetMapping("/editPolling")
    public String editPolling(Model model) {
        model.addAttribute("mcQuestions", mcQuestions);
        return "editPolling";
    }

    @GetMapping({"/commentHistory"})
    public String showCommentHistory(Model model) {
        //model.addAttribute("", );
        List<CommentMaterial> mcommentsList = new ArrayList<>(mComments.values());
        List<CommentPolling> pcommentsList = new ArrayList<>(pComments.values());
        model.addAttribute("mcomments", mcommentsList);
        model.addAttribute("pcomments", pcommentsList);
        return "commentHistory";
    }

    @GetMapping({"/votingHistory"})
    public String showVotingHistory(Model model) {
        //model.addAttribute("", );
        return "votingHistory";
    }
    @GetMapping("/commentHistory/deleteMaterial/{id}")
    public RedirectView deleteMaterialComment(@PathVariable Integer id) {
        mComments.remove(id);
        return new RedirectView("/pj/commentHistory");
    }

    @GetMapping("/commentHistory/deletePolling/{id}")
    public RedirectView deletePollingComment(@PathVariable Integer id) {
        pComments.remove(id);
        return new RedirectView("/pj/commentHistory");
    }
    @GetMapping("/userList")
    public String shoeUseList(Model model) {
        //model.addAttribute("", );
        return "userList";
    }
}