package com.kinderedu.backend.domain.dto;

import com.kinderedu.backend.domain.entities.Turma;
import com.kinderedu.backend.domain.enums.ETurno;

public class TurmaListagemDTO {
    private Long id;
    private String nome;
    private String anoSerie;
    private ETurno turno;
    private String nomeProfessor;
    private int capacidade;

    public TurmaListagemDTO() {
    }

    public TurmaListagemDTO(Turma turma) {
        this.id = turma.getIdTurma();
        this.nome = turma.getNome();
        this.anoSerie = turma.getAnoSerie();
        this.turno = turma.getTurno();
        this.capacidade = turma.getCapacidade();
        if(turma.getProfessor() != null){
            this.nomeProfessor = turma.getProfessor().getNome();
        }

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public ETurno getTurno() {
        return turno;
    }

    public void setTurno(ETurno turno) {
        this.turno = turno;
    }

    public String getNomeProfessor() {
        return nomeProfessor;
    }

    public void setNomeProfessor(String nomeProfessor) {
        this.nomeProfessor = nomeProfessor;
    }

    public String getAnoSerie() {
        return anoSerie;
    }

    public void setAnoSerie(String anoSerie) {
        this.anoSerie = anoSerie;
    }

    public int getCapacidade() {
        return capacidade;
    }

    public void setCapacidade(int capacidade) {
        this.capacidade = capacidade;
    }
}
