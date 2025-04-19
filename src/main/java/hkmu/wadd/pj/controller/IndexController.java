package hkmu.wadd.pj.controller;

import hkmu.wadd.pj.model.User;
import hkmu.wadd.pj.repository.UserListService;
import hkmu.wadd.pj.repository.UserRepository;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class IndexController {

    @GetMapping({"/", "/index"})
    public String index() {
        return "index";
    }

    @GetMapping("/lectures")
    public String lecture() {
        return "lecture";
    }

}