package com.kinderedu.backend.api;

import com.kinderedu.backend.domain.entities.User;
import com.kinderedu.backend.services.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users")
@CrossOrigin("*")
public class UserController {

    private UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/{username}")
    public ResponseEntity<List<User>> getUser(@PathVariable String username){
        var users = userService.findByUsername(username);
        return ResponseEntity.ok(users);
    }

    @PostMapping("")
    public ResponseEntity<User> createUser(@RequestBody User user){
        User createdUser = userService.createUser(user);
        return ResponseEntity.ok(createdUser);
    }

}
