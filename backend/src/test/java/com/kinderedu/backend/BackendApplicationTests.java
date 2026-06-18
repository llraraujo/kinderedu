package com.kinderedu.backend;

import com.kinderedu.backend.domain.dto.AtividadeCadastroDTO;
import com.kinderedu.backend.domain.enums.ETipoAtividade;
import com.kinderedu.backend.services.AlunoService;
import com.kinderedu.backend.services.FotoAlunoService;
import com.kinderedu.backend.services.TurmaService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDate;
import java.time.LocalDateTime;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;

@SpringBootTest
class BackendApplicationTests {

    @Autowired
    private AlunoService alunoService;

    @Autowired
    private TurmaService turmaService;

    @Autowired
    private FotoAlunoService fotoAlunoService;

    @Test
    void contextLoads() {
    }

    @Test
    void mobileIntegrationDataIsAvailable() {
        var profiles = alunoService.alunosPorCpfResponsavel("11111111111");
        assertFalse(profiles.isEmpty());
        assertEquals("Maria Laura", profiles.get(0).getName());

        var students = turmaService.alunosPorCpfProfessor("22222222222");
        assertEquals(4, students.size());

        var activities = alunoService.recuperaAtividadesDashboard(profiles.get(0).getId());
        assertFalse(activities.isEmpty());
    }

    @Test
    void responsavelCanUploadAndListStudentPhotosByDay() {
        var alunoId = alunoService.alunosPorCpfResponsavel("11111111111").get(0).getId();
        var dataHora = LocalDateTime.of(2026, 6, 15, 10, 30);
        var arquivo = new MockMultipartFile(
                "foto",
                "atividade.jpg",
                "image/jpeg",
                new byte[]{1, 2, 3}
        );

        var fotoCriada = fotoAlunoService.cadastrarFoto(
                alunoId,
                "22222222222",
                arquivo,
                "Atividade no patio",
                dataHora
        );

        var fotos = fotoAlunoService.listarFotosPorDia(alunoId, "11111111111", LocalDate.of(2026, 6, 15));
        var arquivoRecuperado = fotoAlunoService.recuperarArquivo(alunoId, fotoCriada.getId(), "11111111111");

        assertFalse(fotos.isEmpty());
        assertEquals("Atividade no patio", fotos.get(0).getDescription());
        assertEquals("10:30", fotos.get(0).getTime());
        assertEquals("image/jpeg", arquivoRecuperado.getContentType());
        assertThrows(
                ResponseStatusException.class,
                () -> fotoAlunoService.listarFotosPorDia(alunoId, "33333333333", LocalDate.of(2026, 6, 15))
        );
    }

    @Test
    void professorCanRegisterAndResponsavelCanListActivitiesByDay() {
        var alunoId = alunoService.alunosPorCpfResponsavel("11111111111").get(0).getId();

        alunoService.cadastrarAtividade(
                alunoId,
                "22222222222",
                new AtividadeCadastroDTO(alunoId, "Comeu todo o lanche", null, null, ETipoAtividade.ALIMENTACAO)
        );

        var atividades = alunoService.listarAtividadesPorDia(alunoId, "11111111111", LocalDate.now());

        assertFalse(atividades.isEmpty());
        assertEquals("ALIMENTACAO", atividades.get(atividades.size() - 1).getTipoAtividade());
        assertEquals("Comeu todo o lanche", atividades.get(atividades.size() - 1).getDescription());
        assertThrows(
                ResponseStatusException.class,
                () -> alunoService.listarAtividadesPorDia(alunoId, "33333333333", LocalDate.now())
        );
    }
}
