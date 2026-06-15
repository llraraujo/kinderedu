package com.kinderedu.backend.services;

import com.kinderedu.backend.domain.dto.*;
import com.kinderedu.backend.domain.entities.Aluno;
import com.kinderedu.backend.domain.entities.Atividade;
import com.kinderedu.backend.domain.entities.Responsavel;
import com.kinderedu.backend.domain.entities.Turma;
import com.kinderedu.backend.respository.AlunoRepository;
import com.kinderedu.backend.respository.AtividadeRespository;
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
    private final AtividadeRespository atividadeRepository;

    @Autowired
    public  AlunoService(AlunoRepository alunoRepository, ResponsavelRepository responsavelRepository, TurmaRepository turmaRepository, AtividadeRespository atividaderespository) {
        this.alunoRepository = alunoRepository;
        this.responsavelRepository = responsavelRepository;
        this.turmaRepository = turmaRepository;
        this.atividadeRepository = atividaderespository;
    }

    public  List<AlunoListagemDTO> todosOsAlunos() {
        List<Aluno> alunos = this.alunoRepository.findAllComTurmaEResponsavel();
        return alunos.stream().map(AlunoListagemDTO::new).toList();
    }


    @Transactional
    public Aluno create(AlunoCadastroDTO alunoDto) {
        Aluno aluno = Mapper.converDtoToEntity(alunoDto);
        Turma turma = turmaRepository.findById(alunoDto.getTurmaId()).get();
        Responsavel responsavel =  responsavelRepository.findByCpf(alunoDto.getCpf());

        if (responsavel == null) {
            ResponsavelCadastroDTO responsavelCadastroDTO = new ResponsavelCadastroDTO(
                    alunoDto.getNomeResponsavel(),
                    alunoDto.getCpf(),
                    alunoDto.getTelefone(),
                    alunoDto.getEmail()
            );
            responsavel =  Mapper.convertDtoToEntity(responsavelCadastroDTO);
            responsavel = responsavelRepository.save(responsavel);
        }

        aluno.setResponsavel(responsavel);
        aluno.setTurma(turma);
        aluno = this.alunoRepository.save(aluno);
        return aluno;
    }

    @Transactional
    public Atividade cadastrarAtividade(Long alunoId, AtividadeCadastroDTO atividadeDto) {
        Aluno aluno = this.alunoRepository.findById(alunoId).get();
        Atividade atividade = Mapper.convertDtoToEntity(atividadeDto);
        atividade.setAluno(aluno);
        return this.atividadeRepository.save(atividade);
    }

    public void recuperaAtividades(Long alunoId) {
        Aluno aluno = this.alunoRepository.findById(alunoId).get();
        List<Atividade> atividades = this.atividadeRepository.findAtividadesByAluno(aluno);
        atividades.forEach(atividade -> System.out.println(atividade.getObservacao()));
    }

    public List<AtividadeDashboardDTO> recuperaAtividadesDashboard(Long alunoId) {
        Aluno aluno = this.alunoRepository.findById(alunoId).get();
        return this.atividadeRepository.findAtividadesDashboardByAluno(aluno);
    }

    public List<AlunoProfileDTO> alunosPorCpfResponsavel(String alunosPorCpfResponsavel){
        var alunos = alunoRepository.findAlunosPorCpfResponsavel(alunosPorCpfResponsavel);
        return alunos.stream().map(AlunoProfileDTO::new).toList();
    }

}
