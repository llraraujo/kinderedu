package com.kinderedu.backend.domain.dto;

import com.kinderedu.backend.domain.entities.Aluno;

import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;
import java.util.Base64;
import java.util.Date;

public class AlunoListagemMobileDTO {
    private Long id;
    private String name;
    private String age;
    private String responsibleName;
    private String imageUrl;

    public AlunoListagemMobileDTO() {
    }

    public  AlunoListagemMobileDTO(Aluno aluno) {
        this.id = aluno.getIdAluno();
        this.name = aluno.getNome();
        this.age = idadeEmString(aluno.getDataNascimento());
        this.responsibleName = aluno.getResponsavel().getNome();
        this.imageUrl = aluno.getFoto() != null ? Base64.getEncoder().encodeToString(aluno.getFoto()) : null;
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

    public String getResponsibleName() {
        return responsibleName;
    }

    public void setResponsibleName(String responsibleName) {
        this.responsibleName = responsibleName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    private String idadeEmString(Date dataNascimento) {
        if (dataNascimento == null) {
            return "N/A";
        }

        LocalDate nascimento = dataNascimento.toInstant()
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

}
