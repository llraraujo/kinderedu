package com.kinderedu.backend.domain.entities;

import java.util.Date;

public class Aluno {
    private Long idAluno;
    private String nome;
    private String matricula;
    private String fichaMedica;
    private byte[] foto;
    private Date dataNascimento;

    public Aluno() {
    }

    public Aluno(Long idAluno, String nome, String matricula, String fichaMedica, byte[] foto, Date dataNascimento) {
        this.idAluno = idAluno;
        this.nome = nome;
        this.matricula = matricula;
        this.fichaMedica = fichaMedica;
        this.foto = foto;
        this.dataNascimento = dataNascimento;
    }

    public Long getIdAluno() {
        return idAluno;
    }

    public void setIdAluno(Long idAluno) {
        this.idAluno = idAluno;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public String getFichaMedica() {
        return fichaMedica;
    }

    public void setFichaMedica(String fichaMedica) {
        this.fichaMedica = fichaMedica;
    }

    public byte[] getFoto() {
        return foto;
    }

    public void setFoto(byte[] foto) {
        this.foto = foto;
    }

    public Date getDataNascimento() {
        return dataNascimento;
    }

    public void setDataNascimento(Date dataNascimento) {
        this.dataNascimento = dataNascimento;
    }
}
