package com.kinderedu.backend.respository;

import com.kinderedu.backend.domain.entities.Aluno;
import com.kinderedu.backend.domain.entities.Turma;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AlunoRepository extends JpaRepository<Aluno,Long>{
    List<Aluno> findByTurma(Turma turma);

    @Query("""
            select aluno
            from Aluno aluno
            join fetch aluno.turma
            join fetch aluno.responsavel
            """)
    List<Aluno> findAllComTurmaEResponsavel();

    @Query(value = """
            select a.*
            from tb_aluno a
            inner join tb_responsavel r
             on a.responsavel_id = r.id_responsavel 
            where r.cpf = :cpfResponsavel
            """, nativeQuery = true)
    List<Aluno> findAlunosPorCpfResponsavel(@Param("cpfResponsavel") String cpfResponsavel);
}
