package hkmu.wadd.pj;

import hkmu.wadd.pj.model.FileEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface FileRepository extends JpaRepository<FileEntity, Long> {
    List<FileEntity> findByMaterialId(Integer materialId);
}