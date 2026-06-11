package com.kinderedu.backend.services;

import com.kinderedu.backend.domain.dto.AlunoCadastroDTO;
import com.kinderedu.backend.domain.entities.Aluno;
import com.kinderedu.backend.domain.entities.Responsavel;
import com.kinderedu.backend.domain.entities.Turma;
import com.kinderedu.backend.respository.AlunoRepository;
import com.kinderedu.backend.util.Mapper;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AlunoService {

    private final AlunoRepository alunoRepository;
    private final ResponsavelService responsavelService;
    private final TurmaService turmaService;

    @Autowired
    public  AlunoService(AlunoRepository alunoRepository, ResponsavelService responsavelService, TurmaService turmaService) {
        this.alunoRepository = alunoRepository;
        this.responsavelService = responsavelService;
        this.turmaService = turmaService;
    }

    public  List<Aluno> todosOsAlunos() {
        return alunoRepository.findAll();
    }

    @Transactional
    public Long create(AlunoCadastroDTO alunoDto) {
        Aluno aluno = Mapper.converDtoToEntity(alunoDto);
        Turma turma = turmaService.buscarPorId(alunoDto.getIdTurma());
        Responsavel responsavel =  responsavelService.buscarPorCpf(alunoDto.getResponsavelDTO().getCpf());

        if (responsavel == null) {
            responsavel = responsavelService.create(alunoDto.getResponsavelDTO());
        }

        aluno.setResponsavel(responsavel);
        aluno.setTurma(turma);
        aluno = this.alunoRepository.save(aluno);
        return aluno.getIdAluno();
    }

}
