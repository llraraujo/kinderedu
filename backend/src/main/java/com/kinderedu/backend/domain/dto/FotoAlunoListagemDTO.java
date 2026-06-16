package com.kinderedu.backend.domain.dto;

import com.kinderedu.backend.domain.entities.FotoAluno;

import java.time.format.DateTimeFormatter;

public class FotoAlunoListagemDTO {

    private Long id;
    private Long alunoId;
    private String imageUrl;
    private String description;
    private String time;
    private String dateTime;
    private String contentType;

    public FotoAlunoListagemDTO() {
    }

    public FotoAlunoListagemDTO(FotoAluno foto, String imageUrl) {
        this.id = foto.getIdFoto();
        this.alunoId = foto.getAluno().getIdAluno();
        this.imageUrl = imageUrl;
        this.description = foto.getDescricao();
        this.time = foto.getDataHora().format(DateTimeFormatter.ofPattern("HH:mm"));
        this.dateTime = foto.getDataHora().toString();
        this.contentType = foto.getContentType();
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

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
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

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }
}
