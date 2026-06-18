package com.kinderedu.backend.util;

import com.kinderedu.backend.domain.dto.*;
import com.kinderedu.backend.domain.entities.*;

import java.time.Instant;
import java.util.Date;

public class Mapper {

    public static Aluno converDtoToEntity(AlunoCadastroDTO alunoDto) {
        Aluno aluno = new Aluno();
        aluno.setNome(alunoDto.getNomeCompleto());
        aluno.setDataNascimento(alunoDto.getDataNascimento());
        aluno.setMatricula(alunoDto.getMatricula());
        return aluno;
    }

    public static Responsavel convertDtoToEntity(ResponsavelCadastroDTO responsavelDTO) {
        Responsavel responsavel = new Responsavel();
        responsavel.setNome(responsavelDTO.getNome());
        responsavel.setCpf(responsavelDTO.getCpf());
        responsavel.setTelefone(responsavelDTO.getTelefone());
        responsavel.setEmail(responsavelDTO.getEmail());
        return responsavel;
    }

    public static Turma  convertDtoToEntity(TurmaCadastroDTO turmaDTO) {
        Turma turma = new Turma();
        turma.setNome(turmaDTO.getNome());
        turma.setAnoSerie(turmaDTO.getAnoSerie());
        turma.setCapacidade(turmaDTO.getCapacidade());
        turma.setTurno(turmaDTO.getTurno());
        return turma;
    }

    public static Professor convertDtoToEntity(ProfessorCadastroDTO professorDto) {
        Professor professor = new Professor();
        professor.setNome(professorDto.getNome());
        professor.setCpf(professorDto.getCpf());
        professor.setTelefone(professorDto.getTelefone());
        professor.setEmailInstitucional(professorDto.getEmailInstitucional());
        return professor;
    }

    public static Atividade convertDtoToEntity(AtividadeCadastroDTO atividadeDto){
        Atividade atividade = new Atividade();
        atividade.setData(Date.from(Instant.now()));
        atividade.setObservacao(atividadeDto.getObservacao());
        atividade.setTipo(atividadeDto.getTipo());

        if(atividade.getObservacao() == null && atividadeDto.getInicioSoneca() != null && atividadeDto.getFimSoneca() != null){
            atividade.setObservacao("Soneca: " + atividadeDto.getInicioSoneca() + " - " + atividadeDto.getFimSoneca());
        }

        return atividade;
    }
}
