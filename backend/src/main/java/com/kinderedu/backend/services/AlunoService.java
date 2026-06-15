package com.kinderedu.backend.services;

import com.kinderedu.backend.domain.dto.AlunoCadastroDTO;
import com.kinderedu.backend.domain.dto.AlunoListagemDTO;
import com.kinderedu.backend.domain.dto.AtividadeAlunoCadastroDTO;
import com.kinderedu.backend.domain.dto.ResponsavelCadastroDTO;
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
    public Atividade cadastrarAtividade(Long alunoId, AtividadeAlunoCadastroDTO atividadeDto) {
        Aluno aluno = this.alunoRepository.findById(alunoId).get();
        Atividade atividade = Mapper.convertDtoToEntity(atividadeDto);
        atividade.setAluno(aluno);
        return this.atividadeRepository.save(atividade);
    }


}
