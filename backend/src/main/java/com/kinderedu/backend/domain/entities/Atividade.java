package com.kinderedu.backend.domain.entities;

import com.kinderedu.backend.domain.enums.ETipoAtividade;
import jakarta.persistence.*;

import java.util.Date;

@Entity
@Table(name = "tb_atividade")
public class Atividade {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idAtividade;

    @Enumerated(EnumType.STRING)
    private ETipoAtividade tipo;
    private String observacao;
    private Date data;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "aluno_id", nullable = false)
    private Aluno aluno;

    public Atividade() {
    }

    public Atividade(Long idAtividade, ETipoAtividade tipo, String observacao, Date data) {
        this.idAtividade = idAtividade;
        this.tipo = tipo;
        this.observacao = observacao;
        this.data = data;
    }

    public Long getIdAtividade() {
        return idAtividade;
    }

    public void setIdAtividade(Long idAtividade) {
        this.idAtividade = idAtividade;
    }

    public ETipoAtividade getTipo() {
        return tipo;
    }

    public void setTipo(ETipoAtividade tipo) {
        this.tipo = tipo;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }

    public Date getData() {
        return data;
    }

    public void setData(Date data) {
        this.data = data;
    }

    public Aluno getAluno() {
        return aluno;
    }

    public void setAluno(Aluno aluno) {
        aluno.addAtividade(this);
        this.aluno = aluno;
    }
}
