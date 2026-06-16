package com.kinderedu.backend.respository;

import com.kinderedu.backend.domain.entities.Turma;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface TurmaRepository extends JpaRepository<Turma,Long> {

    @Query("""
            SELECT turma
            FROM Turma turma
            LEFT JOIN FETCH turma.professor
            """)
    List<Turma> findAllComProfessor();
}
