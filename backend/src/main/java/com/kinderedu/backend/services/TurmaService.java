package com.kinderedu.backend.services;

import com.kinderedu.backend.domain.dto.AlunoListagemMobileDTO;
import com.kinderedu.backend.domain.dto.TurmaCadastroDTO;
import com.kinderedu.backend.domain.dto.TurmaListagemDTO;
import com.kinderedu.backend.domain.entities.Aluno;
import com.kinderedu.backend.domain.entities.Turma;
import com.kinderedu.backend.respository.AlunoRepository;
import com.kinderedu.backend.respository.TurmaRepository;
import com.kinderedu.backend.util.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;

@Service
public class TurmaService {

    private final TurmaRepository turmaRepository;
    private final AlunoRepository alunoRepository;

    @Autowired
    public TurmaService(TurmaRepository turmaRepository, AlunoRepository alunoRepository) {
        this.turmaRepository = turmaRepository;
        this.alunoRepository = alunoRepository;
    }

    public List<TurmaListagemDTO> todasAsTurmas() {
        List<Turma> turmas = this.turmaRepository.findAllComProfessor();
        return  turmas.stream().map(TurmaListagemDTO::new).toList();
    }

    public Turma create(TurmaCadastroDTO turmaDTO){
        Turma turma = Mapper.convertDtoToEntity(turmaDTO);
        turma = this.turmaRepository.save(turma);
        return turma;
    }

    public Turma buscarPorId(Long id) {
        return this.turmaRepository.findById(id).get();
    }

    public List<AlunoListagemMobileDTO> alunosPorCpfProfessor(String professorCpf){
        List<Aluno> alunos = alunoRepository.findByProfessorCpfComResponsavel(professorCpf);
        return alunos.stream().map(AlunoListagemMobileDTO::new).toList();
    }
}
