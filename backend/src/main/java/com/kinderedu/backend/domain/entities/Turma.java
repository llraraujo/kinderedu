package com.kinderedu.backend.domain.entities;

import com.kinderedu.backend.domain.enums.ETurno;
import jakarta.persistence.*;

import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "tb_turma")
public class Turma {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idTurma;
    private String nome;
    private String anoSerie;
    private Integer capacidade;
    private ETurno turno;

    @OneToOne(mappedBy = "turma" ,fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
    private Professor professor;

    @OneToMany(
            mappedBy = "turma",
            cascade = CascadeType.ALL,
            orphanRemoval = true,
            fetch = FetchType.LAZY
    )
    private Set<Aluno> alunos = new HashSet<>();

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

    public Professor getProfessor() {
        return professor;
    }

    public void setProfessor(Professor professor) {
        professor.setTurma(this);
        this.professor = professor;
    }

    public Set<Aluno> getAlunos() {
        return alunos;
    }

    public void addAluno(Aluno aluno) {
        aluno.setTurma(this);
        this.alunos.add(aluno);
    }
}
