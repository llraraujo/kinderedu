package com.kinderedu.backend.domain.entities;

import jakarta.persistence.*;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "tb_professor")
public class Professor implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idProfessor;
    private String nome;
    private String cpf;
    private String telefone;
    private String emailInstitucional;

    @OneToOne
    @JoinColumn(name = "turma_id", nullable = false)
    private Turma turma;

    public Professor() {
    }

    public Professor(Long idProfessor, String nome, String cpf, String telefone, String emailInstitucional) {
        this.idProfessor = idProfessor;
        this.nome = nome;
        this.cpf = cpf;
        this.telefone = telefone;
        this.emailInstitucional = emailInstitucional;
    }

    public Long getIdProfessor() {
        return idProfessor;
    }

    public void setIdProfessor(Long idProfessor) {
        this.idProfessor = idProfessor;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getEmailInstitucional() {
        return emailInstitucional;
    }

    public void setEmailInstitucional(String emailInstitucional) {
        this.emailInstitucional = emailInstitucional;
    }

    public Turma getTurma() {
        return turma;
    }

    public void setTurma(Turma turma) {
        turma.setProfessor(this);
        this.turma = turma;
    }
}
