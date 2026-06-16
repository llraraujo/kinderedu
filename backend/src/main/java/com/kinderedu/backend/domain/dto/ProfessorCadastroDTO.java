package com.kinderedu.backend.domain.dto;

public class ProfessorCadastroDTO {
    private String nome;
    private String cpf;
    private String telefone;
    private String emailInstitucional;
    private Long idTurma;

    public ProfessorCadastroDTO() {
    }

    public ProfessorCadastroDTO(String nome, String cpf, String telefone, String emailInstitucional, Long idTurma) {
        this.nome = nome;
        this.cpf = cpf;
        this.telefone = telefone;
        this.emailInstitucional = emailInstitucional;
        this.idTurma = idTurma;
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

    public Long getIdTurma() {
        return idTurma;
    }

    public void setIdTurma(Long idTurma) {
        this.idTurma = idTurma;
    }
}
