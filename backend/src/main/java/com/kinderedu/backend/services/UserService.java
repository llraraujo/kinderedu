package com.kinderedu.backend.services;

import com.kinderedu.backend.domain.entities.Professor;
import com.kinderedu.backend.domain.entities.Responsavel;
import com.kinderedu.backend.domain.entities.User;
import com.kinderedu.backend.respository.UserRepository;
import com.kinderedu.backend.util.Roles;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    private final UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public List<User> findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    @Transactional
    public User createUser(User user) {
        return userRepository.save(user);
    }

    @Transactional
    public User create(Professor professor){
        User professorUser = new User(professor.getCpf(), "teste123", Roles.PROFESSOR);
        return this.userRepository.save(professorUser);
    }

    @Transactional
    public User create(Responsavel responsavel){
        User responsavelUser = new User(responsavel.getCpf(), "teste123", Roles.RESPONSAVEL);
        return this.userRepository.save(responsavelUser);
    }
}
