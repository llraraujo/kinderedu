package com.kinderedu.backend.respository;

import com.kinderedu.backend.domain.entities.Responsavel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ResponsavelRepository extends JpaRepository<Responsavel,Long> {
    Responsavel findByCpf(String cpf);
}
