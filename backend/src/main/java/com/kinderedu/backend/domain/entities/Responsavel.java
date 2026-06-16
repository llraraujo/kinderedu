package com.kinderedu.backend.domain.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

import java.io.Serial;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "tb_responsavel")
public class Responsavel implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idResponsavel;
    private String nome;
    @Column(unique = true)
    private String cpf;
    private String telefone;
    @Column(unique = true)
    private String email;
    @OneToMany(
            mappedBy = "responsavel",
            cascade = CascadeType.ALL,
            orphanRemoval = true,
            fetch = FetchType.LAZY
    )
    @JsonIgnore
    private Set<Aluno> alunos = new HashSet<>();

    public Responsavel() {
    }

    public Responsavel(Long idResponsavel, String nome, String cpf, String telefone, String email) {
        this.idResponsavel = idResponsavel;
        this.nome = nome;
        this.cpf = cpf;
        this.telefone = telefone;
        this.email = email;
    }

    public Long getIdResponsavel() {
        return idResponsavel;
    }

    public void setIdResponsavel(Long idResponsavel) {
        this.idResponsavel = idResponsavel;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    public void addAluno(Aluno aluno) {
        aluno.setResponsavel(this);
        this.alunos.add(aluno);
    }
}
