package com.kinderedu.backend.util;

import com.kinderedu.backend.domain.dto.AlunoCadastroDTO;
import com.kinderedu.backend.domain.dto.ResponsavelCadastroDTO;
import com.kinderedu.backend.domain.dto.TurmaCadastroDTO;
import com.kinderedu.backend.domain.entities.Aluno;
import com.kinderedu.backend.domain.entities.Responsavel;
import com.kinderedu.backend.domain.entities.Turma;

public class Mapper {

    public static Aluno converDtoToEntity(AlunoCadastroDTO alunoDto) {
        Aluno aluno = new Aluno();
        aluno.setNome(alunoDto.getNome());
        aluno.setDataNascimento(alunoDto.getDataNascimento());
        aluno.setFoto(alunoDto.getFoto());
        aluno.setFichaMedica(alunoDto.getFichaMedica());
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
}
