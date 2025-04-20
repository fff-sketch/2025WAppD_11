package hkmu.wadd.pj.repository;

import hkmu.wadd.pj.model.LectureFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Optional;

@Service
public class FileService {
    @Autowired
    private FileRepository fileRepository;

    public LectureFile saveFile(MultipartFile file) {
        String fileName = file.getOriginalFilename();
        try {
            LectureFile lectureFile = new LectureFile(fileName, file.getContentType(), file.getBytes());
            return fileRepository.save(lectureFile);
        } catch (Exception e) {}
        return null;
    }

    public Optional<LectureFile> getLectureFileById(int id) {
        return fileRepository.findById(id);
    }

    public List<LectureFile> getFiles() {
        return fileRepository.findAll();
    }
}
