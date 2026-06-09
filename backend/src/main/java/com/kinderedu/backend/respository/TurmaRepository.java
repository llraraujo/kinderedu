package com.kinderedu.backend.respository;

import com.kinderedu.backend.domain.entities.Turma;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TurmaRepository extends JpaRepository<Turma,Long> {
}
