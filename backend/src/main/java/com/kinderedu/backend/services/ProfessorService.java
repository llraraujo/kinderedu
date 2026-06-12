package com.kinderedu.backend.services;

import com.kinderedu.backend.domain.dto.ProfessorCadastroDTO;
import com.kinderedu.backend.domain.dto.ProfessorListagemDTO;
import com.kinderedu.backend.domain.dto.TurmaListagemDTO;
import com.kinderedu.backend.domain.entities.Professor;
import com.kinderedu.backend.domain.entities.Turma;
import com.kinderedu.backend.respository.ProfessorRepository;
import com.kinderedu.backend.respository.TurmaRepository;
import com.kinderedu.backend.util.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProfessorService {

    private final TurmaRepository turmaRepository;
    private final ProfessorRepository professorRepository;

    @Autowired
    public ProfessorService(ProfessorRepository professorRepository, TurmaRepository turmaRepository) {
        this.professorRepository = professorRepository;
        this.turmaRepository = turmaRepository;
    }

    public List<ProfessorListagemDTO> todosOsProfessores() {
       List<Professor> professores = this.professorRepository.findAll();
       return professores.stream().map(ProfessorListagemDTO::new).toList();
    }


    public Professor create(ProfessorCadastroDTO professorDto) {
        Professor professor = Mapper.convertDtoToEntity(professorDto);
        Turma turma = turmaRepository.findById(professorDto.getIdTurma()).get();
        professor.setTurma(turma);
        return this.professorRepository.save(professor);
    }

}
