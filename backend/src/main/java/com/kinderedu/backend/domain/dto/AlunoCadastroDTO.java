package com.kinderedu.backend.domain.dto;

import java.util.Date;

public class AlunoCadastroDTO {

    private String nomeCompleto;
    private String matricula;
    private Date dataNascimento;
    private Long turmaId;
    private String nomeResponsavel;
    private String cpf;
    private String email;
    private String telefone;

    public AlunoCadastroDTO(){

    }

    public AlunoCadastroDTO(String nomeCompleto, String matricula, Date dataNascimento, Long turmaId, String nomeResponsavel, String cpf, String email, String telefone) {
        this.nomeCompleto = nomeCompleto;
        this.matricula = matricula;
        this.dataNascimento = dataNascimento;
        this.turmaId = turmaId;
        this.nomeResponsavel = nomeResponsavel;
        this.cpf = cpf;
        this.email = email;
        this.telefone = telefone;
    }

    public String getNomeCompleto() {
        return nomeCompleto;
    }

    public void setNomeCompleto(String nomeCompleto) {
        this.nomeCompleto = nomeCompleto;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public Date getDataNascimento() {
        return dataNascimento;
    }

    public void setDataNascimento(Date dataNascimento) {
        this.dataNascimento = dataNascimento;
    }

    public Long getTurmaId() {
        return turmaId;
    }

    public void setTurmaId(Long turmaId) {
        this.turmaId = turmaId;
    }

    public String getNomeResponsavel() {
        return nomeResponsavel;
    }

    public void setNomeResponsavel(String nomeResponsavel) {
        this.nomeResponsavel = nomeResponsavel;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }
}
