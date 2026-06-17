package com.kinderedu.backend.services;

import com.kinderedu.backend.domain.dto.ProfessorCadastroDTO;
import com.kinderedu.backend.domain.dto.ProfessorListagemDTO;
import com.kinderedu.backend.domain.entities.Professor;
import com.kinderedu.backend.domain.entities.Turma;
import com.kinderedu.backend.respository.ProfessorRepository;
import com.kinderedu.backend.respository.TurmaRepository;
import com.kinderedu.backend.util.Mapper;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProfessorService {

    private final TurmaRepository turmaRepository;
    private final ProfessorRepository professorRepository;
    private final UserService userService;

    @Autowired
    public ProfessorService(ProfessorRepository professorRepository, TurmaRepository turmaRepository, UserService userService) {
        this.professorRepository = professorRepository;
        this.turmaRepository = turmaRepository;
        this.userService = userService;
    }

    public List<ProfessorListagemDTO> todosOsProfessores() {
       List<Professor> professores = this.professorRepository.findAllComTurma();
       return professores.stream().map(ProfessorListagemDTO::new).toList();
    }


    @Transactional
    public Professor create(ProfessorCadastroDTO professorDto) {
        Professor professor = Mapper.convertDtoToEntity(professorDto);
        Turma turma = turmaRepository.findById(professorDto.getIdTurma()).get();
        professor.setTurma(turma);
        professor =  this.professorRepository.save(professor);
        userService.create(professor);
        return professor;
    }

}
