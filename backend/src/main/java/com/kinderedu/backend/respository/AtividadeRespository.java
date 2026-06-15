package com.kinderedu.backend.respository;

import com.kinderedu.backend.domain.entities.Aluno;
import com.kinderedu.backend.domain.entities.Atividade;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AtividadeRespository extends JpaRepository<Atividade,Long> {

    List<Atividade> findAtividadesByAluno(Aluno aluno);
}
