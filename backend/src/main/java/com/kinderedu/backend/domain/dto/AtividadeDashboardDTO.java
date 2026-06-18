package com.kinderedu.backend.domain.dto;

import com.kinderedu.backend.domain.entities.Atividade;

import java.util.Date;

public class AtividadeDashboardDTO {

    private String tipoAtividade;
    private Long quantidade;
    private Date ultimaAtualizacao;

    public AtividadeDashboardDTO(String tipoAtividade, Long quantidade, Date ultimaAtualizacao) {
        this.tipoAtividade = tipoAtividade;
        this.quantidade = quantidade;
        this.ultimaAtualizacao = ultimaAtualizacao;
    }

    public AtividadeDashboardDTO() {
    }

    public String getTipoAtividade() {
        return tipoAtividade;
    }

    public void setTipoAtividade(String tipoAtividade) {
        this.tipoAtividade = tipoAtividade;
    }

    public Long getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(Long quantidade) {
        this.quantidade = quantidade;
    }

    public Date getUltimaAtualizacao() {
        return ultimaAtualizacao;
    }

    public void setUltimaAtualizacao(Date ultimaAtualizacao) {
        this.ultimaAtualizacao = ultimaAtualizacao;
    }
}
