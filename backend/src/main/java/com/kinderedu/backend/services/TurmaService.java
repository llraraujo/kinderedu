package com.kinderedu.backend.services;

import com.kinderedu.backend.domain.dto.TurmaCadastroDTO;
import com.kinderedu.backend.domain.entities.Turma;
import com.kinderedu.backend.respository.TurmaRepository;
import com.kinderedu.backend.util.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;

@Service
public class TurmaService {

    private final TurmaRepository turmaRepository;

    @Autowired
    public TurmaService(TurmaRepository turmaRepository) {
        this.turmaRepository = turmaRepository;
    }

    public List<Turma> todasAsTurmas() {
       return this.turmaRepository.findAll();
    }

    public Turma create(TurmaCadastroDTO turmaDTO){
        Turma turma = Mapper.convertDtoToEntity(turmaDTO);
        turma = this.turmaRepository.save(turma);
        return turma;
    }

    public Turma buscarPorId(Long id) {
        return this.turmaRepository.findById(id).get();
    }

    private Turma convertDtoToEntity(TurmaCadastroDTO turmaDTO) {
        Turma turma = new Turma();
        turma.setNome(turmaDTO.getNome());
        turma.setAnoSerie(turmaDTO.getAnoSerie());
        turma.setCapacidade(turmaDTO.getCapacidade());
        turma.setTurno(turmaDTO.getTurno());
        return turma;
    }

    private TurmaCadastroDTO convertEntityToDto(TurmaCadastroDTO turmaDTO) {
        Turma turma = new Turma();
        turma.setNome(turmaDTO.getNome());
        turma.setAnoSerie(turmaDTO.getAnoSerie());
        turma.setCapacidade(turmaDTO.getCapacidade());
        turma.setTurno(turmaDTO.getTurno());
        return turmaDTO;
    }
}
