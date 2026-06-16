package com.kinderedu.backend.domain.dto;

import com.kinderedu.backend.domain.enums.ETurno;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;

public class TurmaCadastroDTO {
    private String nome;
    private String anoSerie;
    private Integer capacidade;
    @Enumerated(EnumType.STRING)
    private ETurno turno;

    public TurmaCadastroDTO() {
    }

    public TurmaCadastroDTO(String nome, String anoSerie, Integer capacidade, ETurno turno) {
        this.nome = nome;
        this.anoSerie = anoSerie;
        this.capacidade = capacidade;
        this.turno = turno;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getAnoSerie() {
        return anoSerie;
    }

    public void setAnoSerie(String anoSerie) {
        this.anoSerie = anoSerie;
    }

    public Integer getCapacidade() {
        return capacidade;
    }

    public void setCapacidade(Integer capacidade) {
        this.capacidade = capacidade;
    }

    public ETurno getTurno() {
        return turno;
    }

    public void setTurno(ETurno turno) {
        this.turno = turno;
    }
}
