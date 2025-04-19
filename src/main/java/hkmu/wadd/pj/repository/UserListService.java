package hkmu.wadd.pj.repository;

import hkmu.wadd.pj.model.User;
import jakarta.annotation.Resource;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserListService {
    @Resource
    private UserRepository userRepository;

    @Transactional
    public List<User> getUsers() {
        return userRepository.findAll();
    }

    @Transactional
    public void deleteUser(String username) {
        User user = userRepository.findById(username).orElse(null);
        userRepository.delete(user);
    }

    @Transactional
    public void addUser(String username, String password, String fullName, String email, String phone/*, String[] roles*/) {
        User user = new User(username, password, fullName, email, phone/*, roles*/);
        userRepository.save(user);
    }

    @Transactional
    public void editUser(String username, String password, String fullName, String email, String phone) {
        User user = userRepository.findById(username).orElse(null);
        user.setPassword(password);
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);

        userRepository.save(user);
    }
}
