package com.kinderedu.backend.services;

import com.kinderedu.backend.domain.dto.ResponsavelCadastroDTO;
import com.kinderedu.backend.domain.entities.Responsavel;
import com.kinderedu.backend.respository.ResponsavelRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ResponsavelService {

    private final ResponsavelRepository responsavelRepository;

    @Autowired
    public ResponsavelService(ResponsavelRepository responsavelRepository) {
        this.responsavelRepository = responsavelRepository;
    }

    private final static List<Responsavel> responsaveis = new ArrayList<Responsavel>(){
        {
            add(new Responsavel(1L, "Maria Silva", "123.456.789-10", "(11) 99999-9999", "marisilva@gmail.com"));
            add(new Responsavel(2L, "Adriano Pereira", "123.456.745-08", "(11) 88888-9999", "apereira@gmail.com"));
        }
    };

    public List<Responsavel> todosOsResponsaveis() {
        return this.responsaveis;
    }

    public Long create(ResponsavelCadastroDTO responsavelDTO) {
        Responsavel responsavel = convertDtoToEntity(responsavelDTO);
        responsavel = this.responsavelRepository.save(responsavel);
        return responsavel.getIdResponsavel();
    }

    private Responsavel convertDtoToEntity(ResponsavelCadastroDTO responsavelDTO) {
        Responsavel responsavel = new Responsavel();
        responsavel.setNome(responsavelDTO.getNome());
        responsavel.setCpf(responsavelDTO.getCpf());
        responsavel.setTelefone(responsavelDTO.getTelefone());
        responsavel.setEmail(responsavelDTO.getEmail());
        return responsavel;
    }
}
