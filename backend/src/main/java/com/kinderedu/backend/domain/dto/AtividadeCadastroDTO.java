package com.kinderedu.backend.domain.dto;

import com.kinderedu.backend.domain.enums.ETipoAtividade;



public class AtividadeCadastroDTO {

    private Long alunoId;
    private String observacao;
    private String inicioSoneca;
    private String fimSoneca;
    private ETipoAtividade tipo;


    public AtividadeCadastroDTO() {
    }

    public AtividadeCadastroDTO(Long alunoId, String observacao, String inicioSoneca, String fimSoneca, ETipoAtividade tipo) {
        this.alunoId = alunoId;
        this.observacao = observacao;
        this.inicioSoneca = inicioSoneca;
        this.fimSoneca = fimSoneca;
        this.tipo = tipo;
    }

    public Long getAlunoId() {
        return alunoId;
    }

    public void setAlunoId(Long alunoId) {
        this.alunoId = alunoId;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }

    public String getInicioSoneca() {
        return inicioSoneca;
    }

    public void setInicioSoneca(String inicioSoneca) {
        this.inicioSoneca = inicioSoneca;
    }

    public String getFimSoneca() {
        return fimSoneca;
    }

    public void setFimSoneca(String fimSoneca) {
        this.fimSoneca = fimSoneca;
    }

    public ETipoAtividade getTipo() {
        return tipo;
    }

    public void setTipo(ETipoAtividade tipo) {
        this.tipo = tipo;
    }
}
