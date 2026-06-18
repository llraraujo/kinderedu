package com.kinderedu.backend.respository;

import com.kinderedu.backend.domain.entities.Professor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ProfessorRepository  extends JpaRepository<Professor,Long> {
    Professor findByCpf(String cpf);

    @Query("""
            SELECT professor
            FROM Professor professor
            JOIN FETCH professor.turma
            """)
    List<Professor> findAllComTurma();
}
