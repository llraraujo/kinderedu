package com.kinderedu.backend.respository;

import com.kinderedu.backend.domain.entities.Aluno;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AlunoRepository extends JpaRepository<Aluno,Long>{
}
