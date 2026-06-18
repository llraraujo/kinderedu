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
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
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
    public Atividade cadastrarAtividade(Long alunoId, String cpfProfessor, AtividadeCadastroDTO atividadeDto) {
        Aluno aluno = recuperarAlunoDoProfessor(alunoId, cpfProfessor);
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

    @Transactional
    public List<AtividadeListagemDTO> listarAtividadesPorDia(Long alunoId, String cpfResponsavel, LocalDate data) {
        recuperarAlunoDoResponsavel(alunoId, cpfResponsavel);

        Date inicio = Date.from(data.atStartOfDay(ZoneId.systemDefault()).toInstant());
        Date fim = Date.from(data.plusDays(1).atStartOfDay(ZoneId.systemDefault()).toInstant());

        return atividadeRepository
                .findAtividadesPorAlunoResponsavelEData(alunoId, cpfResponsavel, inicio, fim)
                .stream()
                .map(AtividadeListagemDTO::new)
                .toList();
    }

    private Aluno recuperarAlunoDoResponsavel(Long alunoId, String cpfResponsavel) {
        Aluno aluno = alunoRepository.findById(alunoId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Aluno nao encontrado."));

        if (aluno.getResponsavel() == null || !cpfResponsavel.equals(aluno.getResponsavel().getCpf())) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Responsavel nao autorizado para este aluno.");
        }

        return aluno;
    }

    private Aluno recuperarAlunoDoProfessor(Long alunoId, String cpfProfessor) {
        Aluno aluno = alunoRepository.findById(alunoId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Aluno nao encontrado."));

        if (aluno.getTurma() == null
                || aluno.getTurma().getProfessor() == null
                || !cpfProfessor.equals(aluno.getTurma().getProfessor().getCpf())) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Professor nao autorizado para este aluno.");
        }

        return aluno;
    }
}
