package com.kinderedu.backend.services;

import com.kinderedu.backend.domain.entities.Turma;
import com.kinderedu.backend.domain.enums.ETurno;
import com.kinderedu.backend.respository.TurmaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class TurmaService {

    private final TurmaRepository turmaRepository;

    @Autowired
    public TurmaService(TurmaRepository turmaRepository) {
        this.turmaRepository = turmaRepository;
    }

    private final static List<Turma> turmas = new ArrayList<Turma>(){
        {
            add(new Turma(1L,"JARDIM 1"," Maternal 1", 5, ETurno.MANHA));
            add(new Turma(2L,"JARDIM 2"," Maternal 2", 5, ETurno.TARDE));
        }
    };

    public List<Turma> todasAsTurmas() {
       return this.turmas;
    }
}
