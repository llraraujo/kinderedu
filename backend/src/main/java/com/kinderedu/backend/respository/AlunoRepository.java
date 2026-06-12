package com.kinderedu.backend.respository;

import com.kinderedu.backend.domain.entities.Aluno;
import com.kinderedu.backend.domain.entities.Turma;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AlunoRepository extends JpaRepository<Aluno,Long>{
    List<Aluno> findByTurma(Turma turma);
}
