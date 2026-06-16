package com.kinderedu.backend.services;

import com.kinderedu.backend.domain.dto.ResponsavelCadastroDTO;
import com.kinderedu.backend.domain.entities.Responsavel;
import com.kinderedu.backend.respository.ResponsavelRepository;
import com.kinderedu.backend.util.Mapper;
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

    public List<Responsavel> todosOsResponsaveis() {
        return this.responsavelRepository.findAll();
    }


    public Responsavel buscarPorId(Long id) {
        return this.responsavelRepository.findById(id).get();
    }

    public Responsavel buscarPorCpf(String cpf) {
        return this.responsavelRepository.findByCpf(cpf);
    }

    public Responsavel create(ResponsavelCadastroDTO responsavelDTO) {
        Responsavel responsavel = Mapper.convertDtoToEntity(responsavelDTO);
        responsavel = this.responsavelRepository.save(responsavel);
        return responsavel;
    }

}
