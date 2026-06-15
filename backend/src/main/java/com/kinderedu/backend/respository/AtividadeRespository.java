package com.kinderedu.backend.respository;

import com.kinderedu.backend.domain.dto.AtividadeDashboardDTO;
import com.kinderedu.backend.domain.entities.Aluno;
import com.kinderedu.backend.domain.entities.Atividade;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface AtividadeRespository extends JpaRepository<Atividade,Long> {

    List<Atividade> findAtividadesByAluno(Aluno aluno);

    @Query("""
    SELECT new com.kinderedu.backend.domain.dto.AtividadeDashboardDTO(
        CAST(a.tipo AS string),
        COUNT(a),
        MAX(a.data)
    )
    FROM Atividade a
    WHERE a.aluno = :aluno
    GROUP BY a.tipo
""")
    List<AtividadeDashboardDTO> findAtividadesDashboardByAluno(Aluno aluno);
}
