package com.kinderedu.backend.services;

import com.kinderedu.backend.domain.entities.Responsavel;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ResponsavelService {

    private final static List<Responsavel> responsaveis = new ArrayList<Responsavel>(){
        {
            add(new Responsavel(1L, "Maria Silva", "123.456.789-10", "(11) 99999-9999", "marisilva@gmail.com"));
            add(new Responsavel(2L, "Adriano Pereira", "123.456.745-08", "(11) 88888-9999", "apereira@gmail.com"));
        }
    };

    public List<Responsavel> todosOsResponsaveis() {
        return this.responsaveis;
    }
}
