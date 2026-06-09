package com.kinderedu.backend.respository;

import com.kinderedu.backend.domain.entities.Professor;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProfessorRepository  extends JpaRepository<Professor,Long> {
}
