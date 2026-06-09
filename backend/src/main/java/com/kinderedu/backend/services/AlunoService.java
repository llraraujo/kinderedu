package com.kinderedu.backend.services;

import com.kinderedu.backend.domain.entities.Aluno;
import com.kinderedu.backend.respository.AlunoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class AlunoService {

    private final AlunoRepository alunoRepository;

    @Autowired
    public  AlunoService(AlunoRepository alunoRepository) {
        this.alunoRepository = alunoRepository;
    }

    private final static List<Aluno> alunos = new ArrayList<>(){
        {
            Aluno aluno1 = new Aluno(1L, "João da Silva", "IESJABC", null, null, null);
            Aluno aluno2 = new Aluno(2L, "Maria Laura", "IESJDEF", null, null, null);
            // Responsavel respo1 = new Responsavel(1L, "Maria Silva", "123.456.789-10", "(11) 99999-9999", "marisilva@gmail.com");
            //Responsavel respo2 = new Responsavel(2L, "Adriano Pereira", "123.456.745-08", "(11) 88888-9999", "apereira@gmail.com");
            // aluno1.setResponsavel(respo1);
            //aluno2.setResponsavel(respo2);
            add(aluno1);
            add(aluno2);
        }
    };

    public  List<Aluno> todosOsAlunos() {
        return alunos;
    }
}
