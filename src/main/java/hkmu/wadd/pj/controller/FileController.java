package hkmu.wadd.pj.controller;

import hkmu.wadd.pj.model.LectureFile;
import hkmu.wadd.pj.repository.FileService;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
/*
@Controller
public class FileController {
    @Autowired
    private FileService fileService;

    @GetMapping("/")
    public String get(Model model) {
        List<LectureFile> files = fileService.getFiles();
        model.addAttribute("files", files);
        return "index";
    }

    @PostMapping("/upload")
    public String upload(@RequestParam("file") MultipartFile[] file) {
        for (MultipartFile fileItem : file) {
            fileService.saveFile(fileItem);
        }
        return "redirect:/";
    }

    @GetMapping("/download/{fileId}")
    public ResponseEntity<ByteArrayResource> download(@PathVariable int fileId) {
        LectureFile file = fileService.getLectureFileById(fileId).get();
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(file.getFileType()))
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment:filename=\""+file.getFileName()+"\"")
                .body(new ByteArrayResource(file.getData()));
    }
}*/
