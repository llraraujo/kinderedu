package com.kinderedu.backend.domain.dto;

import com.kinderedu.backend.domain.entities.Atividade;
import com.kinderedu.backend.domain.enums.ETipoAtividade;

import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

public class AtividadeListagemDTO {

    private Long id;
    private Long alunoId;
    private String tipoAtividade;
    private String title;
    private String description;
    private String time;
    private String dateTime;

    public AtividadeListagemDTO() {
    }

    public AtividadeListagemDTO(Atividade atividade) {
        this.id = atividade.getIdAtividade();
        this.alunoId = atividade.getAluno().getIdAluno();
        this.tipoAtividade = atividade.getTipo().name();
        this.title = tituloPorTipo(atividade.getTipo());
        this.description = atividade.getObservacao();
        this.time = atividade.getData().toInstant()
                .atZone(ZoneId.systemDefault())
                .format(DateTimeFormatter.ofPattern("HH:mm"));
        this.dateTime = atividade.getData().toInstant()
                .atZone(ZoneId.systemDefault())
                .toLocalDateTime()
                .toString();
    }

    private String tituloPorTipo(ETipoAtividade tipo) {
        return switch (tipo) {
            case ALIMENTACAO -> "Refeicao";
            case SONECA -> "Soneca";
            case HIGIENE -> "Higiene";
        };
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getAlunoId() {
        return alunoId;
    }

    public void setAlunoId(Long alunoId) {
        this.alunoId = alunoId;
    }

    public String getTipoAtividade() {
        return tipoAtividade;
    }

    public void setTipoAtividade(String tipoAtividade) {
        this.tipoAtividade = tipoAtividade;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getDateTime() {
        return dateTime;
    }

    public void setDateTime(String dateTime) {
        this.dateTime = dateTime;
    }
}
