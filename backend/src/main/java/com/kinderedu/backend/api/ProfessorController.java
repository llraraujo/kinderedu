package com.kinderedu.backend.api;

import com.kinderedu.backend.domain.dto.ProfessorCadastroDTO;
import com.kinderedu.backend.domain.dto.ProfessorListagemDTO;
import com.kinderedu.backend.domain.entities.Professor;
import com.kinderedu.backend.services.ProfessorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/professores")
@CrossOrigin("*")
public class ProfessorController extends  BaseController {

    private final ProfessorService professorService;

    @Autowired
    public ProfessorController(ProfessorService professorService) {
        this.professorService = professorService;
    }

    @RequestMapping(method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<ProfessorListagemDTO>> index(){
        return ResponseEntity.ok(professorService.todosOsProfessores());
    }

    @RequestMapping(method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Professor> create(@RequestBody ProfessorCadastroDTO professorDto){
        Professor professor = professorService.create(professorDto);
        URI uri = createRouteUri(professor.getIdProfessor());
        return ResponseEntity.created(uri).build();
    }
}
