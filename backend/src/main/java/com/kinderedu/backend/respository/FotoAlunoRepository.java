package com.kinderedu.backend.respository;

import com.kinderedu.backend.domain.entities.FotoAluno;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface FotoAlunoRepository extends JpaRepository<FotoAluno, Long> {

    List<FotoAluno> findByAluno_IdAlunoAndAluno_Responsavel_CpfAndDataHoraBetweenOrderByDataHoraAsc(
            Long alunoId,
            String cpfResponsavel,
            LocalDateTime inicio,
            LocalDateTime fim
    );

    Optional<FotoAluno> findByIdFotoAndAluno_IdAlunoAndAluno_Responsavel_Cpf(
            Long idFoto,
            Long alunoId,
            String cpfResponsavel
    );
}
