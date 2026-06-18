package com.kinderedu.backend.domain.dto;

import com.kinderedu.backend.domain.entities.Aluno;

import java.util.Date;

public class AlunoListagemDTO {
    private Long id;
    private String nomeCompleto;
    private String matricula;
    private Date dataNascimento;
    private Long turmaId;
    private String nomeResponsavel;
    private String cpf;
    private String email;
    private String telefone;

    public AlunoListagemDTO() {
    }

    public AlunoListagemDTO(Aluno aluno) {
        this.id = aluno.getIdAluno();
        this.nomeCompleto = aluno.getNome();
        this.matricula = aluno.getMatricula();
        this.dataNascimento = aluno.getDataNascimento();
        this.turmaId = aluno.getTurma().getIdTurma();
        this.nomeResponsavel = aluno.getResponsavel().getNome();
        this.cpf = aluno.getResponsavel().getCpf();
        this.email = aluno.getResponsavel().getEmail();
        this.telefone = aluno.getResponsavel().getTelefone();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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
