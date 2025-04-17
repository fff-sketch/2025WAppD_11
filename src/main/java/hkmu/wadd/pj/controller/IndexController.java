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

    @Resource
    private UserListService userListService;
    @Resource
    private UserRepository userRepository;
    @GetMapping("/list")
    public String list(ModelMap model) {
        model.addAttribute("users", userListService.getUsers());
        return "list";
    }

    @GetMapping("/delete/{username}")
    public String deleteTicket(@PathVariable("username") String username) {
        userListService.deleteUser(username);
        return "redirect:/list";
    }

    @GetMapping("/addUser")
    public String addUser(Model model) {
        model.addAttribute("user", new User());
        return "addUser";
    }

    @GetMapping("/editUser/{username}")
    public String editUser(@PathVariable("username") String username, ModelMap model) {
        model.addAttribute("user", userRepository.findByUsername(username));
        return "editUser";
    }

}