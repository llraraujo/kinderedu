package com.kinderedu.backend.services;

import com.kinderedu.backend.domain.dto.AlunoCadastroDTO;
import com.kinderedu.backend.domain.entities.Aluno;
import com.kinderedu.backend.domain.entities.Responsavel;
import com.kinderedu.backend.domain.entities.Turma;
import com.kinderedu.backend.respository.AlunoRepository;
import com.kinderedu.backend.respository.ResponsavelRepository;
import com.kinderedu.backend.respository.TurmaRepository;
import com.kinderedu.backend.util.Mapper;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AlunoService {

    private final AlunoRepository alunoRepository;
    private final ResponsavelRepository responsavelRepository;
    private final TurmaRepository turmaRepository;

    @Autowired
    public  AlunoService(AlunoRepository alunoRepository, ResponsavelRepository responsavelRepository, TurmaRepository turmaRepository) {
        this.alunoRepository = alunoRepository;
        this.responsavelRepository = responsavelRepository;
        this.turmaRepository = turmaRepository;
    }

    public  List<Aluno> todosOsAlunos() {
        return alunoRepository.findAll();
    }


    @Transactional
    public Long create(AlunoCadastroDTO alunoDto) {
        Aluno aluno = Mapper.converDtoToEntity(alunoDto);
        Turma turma = turmaRepository.findById(alunoDto.getIdTurma()).get();
        Responsavel responsavel =  responsavelRepository.findByCpf(alunoDto.getResponsavelDTO().getCpf());

        if (responsavel == null) {
            responsavel =  Mapper.convertDtoToEntity(alunoDto.getResponsavelDTO());
            responsavel = responsavelRepository.save(responsavel);
        }

        aluno.setResponsavel(responsavel);
        aluno.setTurma(turma);
        aluno = this.alunoRepository.save(aluno);
        return aluno.getIdAluno();
    }

}
