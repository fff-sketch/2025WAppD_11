package hkmu.wadd.pj.repository;

import hkmu.wadd.pj.model.LectureFile;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FileRepository extends JpaRepository<LectureFile, Integer> {
}
