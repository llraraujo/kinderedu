package com.kinderedu.backend.services;

import com.kinderedu.backend.domain.dto.ProfessorCadastroDTO;
import com.kinderedu.backend.domain.entities.Professor;
import com.kinderedu.backend.domain.entities.Turma;
import com.kinderedu.backend.respository.ProfessorRepository;
import com.kinderedu.backend.util.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProfessorService {

    private final TurmaService turmaService;
    private final ProfessorRepository professorRepository;

    @Autowired
    public ProfessorService(ProfessorRepository professorRepository, TurmaService turmaService) {
        this.professorRepository = professorRepository;
        this.turmaService = turmaService;
    }

    public List<Professor> todosOsProfessores() {
        return this.professorRepository.findAll();
    }

    public Professor buscarPorId(Long id) {
        return this.professorRepository.findById(id).get();
    }

    public Professor buscarPorCpf(String cpf) {
        return this.professorRepository.findByCpf(cpf);
    }

    public Professor create(ProfessorCadastroDTO professorDto) {
        Professor professor = Mapper.convertDtoToEntity(professorDto);
        Turma turma = turmaService.buscarPorId(professorDto.getIdTurma());
        professor.setTurma(turma);
        return this.professorRepository.save(professor);
    }

}
