package com.kinderedu.backend.respository;

import com.kinderedu.backend.domain.entities.Atividade;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AtividadeRespository extends JpaRepository<Atividade,Long> {
}
