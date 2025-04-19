package hkmu.wadd.pj.controller;

import hkmu.wadd.pj.model.User;
import hkmu.wadd.pj.repository.UserListService;
import hkmu.wadd.pj.repository.UserRepository;
import jakarta.annotation.Resource;
import jakarta.transaction.Transactional;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ListController {
    @Resource
    private UserListService userListService;
    @Resource
    private UserRepository userRepository;
    @GetMapping("/list")
    public String list(ModelMap model) {
        model.addAttribute("users", userListService.getUsers());
        System.out.println(userListService.getUsers());
        return "list";
    }

    @GetMapping("/delete/{username}")
    public String deleteTicket(@PathVariable("username") String username) {
        userListService.deleteUser(username);
        return "redirect:/list";
    }

    @GetMapping("/addUser")
    public String addUserForm(Model model) {
        model.addAttribute("user", new User());
        return "addUser";
    }



    @GetMapping("/editUser/{username}")
    public String editUserForm(@PathVariable("username") String username, ModelMap model) {
        model.addAttribute("user", userRepository.findByUsername(username));
        model.addAttribute("username", username);
        return "editUser";
    }
    @Resource
    private JdbcTemplate jdbcTemplate;

    @PostMapping("/editUser/{username}")
    @Transactional
    public String processEditUser(@ModelAttribute User user, RedirectAttributes redirectAttributes) {
        jdbcTemplate.update(
                "UPDATE users SET password=?, full_name=?, email=?, phone=?  WHERE username=?",
                user.getPassword(),
                user.getFullName(),
                user.getEmail(),
                user.getPhone(),
                user.getUsername());
        return "redirect:/list";

    }

}
