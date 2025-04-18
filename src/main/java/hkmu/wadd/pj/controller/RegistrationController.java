package hkmu.wadd.pj.controller;

import hkmu.wadd.pj.model.User;
import jakarta.transaction.Transactional;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
public class RegistrationController {

    private final JdbcTemplate jdbcTemplate;

    public RegistrationController(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    @Transactional
    public String processRegistration(@ModelAttribute User user, RedirectAttributes redirectAttributes) {

        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM users WHERE username = ?", Integer.class, user.getUsername());
        if (count != null && count > 0) {
            redirectAttributes.addFlashAttribute("error", "Username already exists. Please choose a different username.");
            return "register";
        }

        String passwordWithNoop = "{noop}" + user.getPassword();
        jdbcTemplate.update(
                "INSERT INTO users (username, password, fullName, email, phone) VALUES (?, ?, ?, ?, ?)",
                user.getUsername(),
                passwordWithNoop,
                user.getFullName(),
                user.getEmail(),
                user.getPhone());
        jdbcTemplate.update(
                "INSERT INTO user_roles (username, role) VALUES (?, ?)",
                user.getUsername(),
                "ROLE_USER");

        return "redirect:/index";

    }
}

