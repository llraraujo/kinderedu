package com.kinderedu.backend.domain.dto;

import java.util.Date;

public class AlunoCadastroDTO {

    private String nome;
    private String matricula;
    private String fichaMedica;
    private byte[] foto;
    private Date dataNascimento;
    ResponsavelCadastroDTO responsavelDTO;
    private Long idTurma;

    public AlunoCadastroDTO(){}

    public AlunoCadastroDTO(String nome, String matricula, String fichaMedica, byte[] foto, Date dataNascimento, ResponsavelCadastroDTO responsavelDTO, Long idTurma) {
        this.nome = nome;
        this.matricula = matricula;
        this.fichaMedica = fichaMedica;
        this.foto = foto;
        this.dataNascimento = dataNascimento;
        this.responsavelDTO = responsavelDTO;
        this.idTurma = idTurma;
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

    public ResponsavelCadastroDTO getResponsavelDTO() {
        return responsavelDTO;
    }

    public void setResponsavelDTO(ResponsavelCadastroDTO responsavelDTO) {
        this.responsavelDTO = responsavelDTO;
    }

    public Long getIdTurma() {
        return idTurma;
    }

    public void setIdTurma(Long idTurma) {
        this.idTurma = idTurma;
    }
}
