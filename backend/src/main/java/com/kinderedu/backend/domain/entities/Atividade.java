package com.kinderedu.backend.domain.entities;

import com.kinderedu.backend.domain.enums.ETipoAtividade;

import java.util.Date;

public class Atividade {
    private Long idAtividade;
    private ETipoAtividade tipo;
    private String observacao;
    private Date data;

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
}
