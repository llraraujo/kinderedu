package com.kinderedu.backend.domain.dto;

import com.kinderedu.backend.domain.entities.Professor;

public class ProfessorListagemDTO {
    private Long id;
    private String nome;
    private String emailInstitucional;
    private String cpf;
    private String telefone;
    private Long idTurma;

    public ProfessorListagemDTO() {
    }

    public ProfessorListagemDTO(Professor professor) {
        this.id = professor.getIdProfessor();
        this.nome = professor.getNome();
        this.emailInstitucional = professor.getEmailInstitucional();
        this.cpf = professor.getCpf();
        this.telefone = professor.getTelefone();
        this.idTurma = professor.getTurma().getIdTurma();
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

    public String getEmailInstitucional() {
        return emailInstitucional;
    }

    public void setEmailInstitucional(String emailInstitucional) {
        this.emailInstitucional = emailInstitucional;
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

    public Long getIdTurma() {
        return idTurma;
    }

    public void setIdTurma(Long idTurma) {
        this.idTurma = idTurma;
    }
}
