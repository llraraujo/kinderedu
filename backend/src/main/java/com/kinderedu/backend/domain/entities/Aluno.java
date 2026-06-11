package com.kinderedu.backend.domain.entities;

import jakarta.persistence.*;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "tb_aluno")
public class Aluno  implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idAluno;
    private String nome;
    private String matricula;
    private String fichaMedica;
    private byte[] foto;
    private Date dataNascimento;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "turma_id", nullable = false)
    private Turma turma;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "responsavel_id", nullable = false)
    private Responsavel responsavel;
    @OneToMany(mappedBy = "aluno", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private Set<Atividade> atividades = new HashSet<>();

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

    public Turma getTurma() {
        return turma;
    }

    public void setTurma(Turma turma) {
        //turma.addAluno(this);
        this.turma = turma;
    }

    public Responsavel getResponsavel() {
        return this.responsavel;
    }


    public void setResponsavel(Responsavel responsavel) {
        //responsavel.addAluno(this);
        this.responsavel = responsavel;
    }
    public Set<Atividade> getAtividades() {
        return atividades;
    }

    public void addAtividade(Atividade atividade) {
        atividade.setAluno(this);
        this.atividades.add(atividade);
    }
}
