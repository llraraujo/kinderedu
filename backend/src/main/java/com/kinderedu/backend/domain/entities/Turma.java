package com.kinderedu.backend.domain.entities;

import com.kinderedu.backend.domain.enums.ETurno;

public class Turma {
    private Long idTurma;
    private String nome;
    private String anoSerie;
    private Integer capacidade;
    private ETurno turno;

    public Turma() {
    }

    public Turma(Long idTurma, String nome, String anoSerie, Integer capacidade, ETurno turno) {
        this.idTurma = idTurma;
        this.nome = nome;
        this.anoSerie = anoSerie;
        this.capacidade = capacidade;
        this.turno = turno;
    }

    public Long getIdTurma() {
        return idTurma;
    }

    public void setIdTurma(Long idTurma) {
        this.idTurma = idTurma;
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
