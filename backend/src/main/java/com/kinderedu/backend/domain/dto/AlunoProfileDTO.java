package com.kinderedu.backend.domain.dto;

import com.kinderedu.backend.domain.entities.Aluno;

import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;
import java.util.Date;
import java.time.Instant;

public class AlunoProfileDTO {

    private Long id;
    private String name;
    private String age;
    private String imageUrl;
    private Date currentDate;

    public AlunoProfileDTO(Aluno aluno){
        this.id = aluno.getIdAluno();
        this.name = aluno.getNome();
        this.age = this.idadeEmString(aluno.getDataNascimento());
        this.imageUrl = "";
        this.currentDate = Date.from(Instant.now());
    }

    private String idadeEmString(Date dataNascimento) {
        if (dataNascimento == null) {
            return "N/A";
        }

        LocalDate nascimento = Instant.ofEpochMilli(dataNascimento.getTime())
                .atZone(ZoneId.systemDefault())
                .toLocalDate();

        LocalDate hoje = LocalDate.now();
        Period periodo = Period.between(nascimento, hoje);

        if (periodo.getYears() >= 1) {
            int anos = periodo.getYears();
            return anos == 1 ? "1 ano" : anos + " anos";
        }

        int meses = periodo.getMonths();
        return meses == 1 ? "1 mês" : meses + " meses";
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Date getCurrentDate() {
        return currentDate;
    }

    public void setCurrentDate(Date currentDate) {
        this.currentDate = currentDate;
    }
}
