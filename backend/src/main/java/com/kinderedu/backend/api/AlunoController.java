package com.kinderedu.backend.api;


import com.kinderedu.backend.domain.dto.AlunoCadastroDTO;
import com.kinderedu.backend.domain.entities.Aluno;
import com.kinderedu.backend.services.AlunoService;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/alunos")
@CrossOrigin("*")
public class AlunoController extends  BaseController{

    private final AlunoService alunoService;

    public  AlunoController(@Autowired AlunoService alunoService) {
        this.alunoService = alunoService;
    }

    @RequestMapping(method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses({@ApiResponse(responseCode = "200")})
    public ResponseEntity<List<Aluno>> index() {
        var alunos = alunoService.todosOsAlunos();
        return ResponseEntity.ok(alunos);
    }

    @RequestMapping(method =  RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE,produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses({@ApiResponse(responseCode = "201")})
    public ResponseEntity create(@RequestBody  AlunoCadastroDTO alunoDTO) {
        Long id = this.alunoService.create(alunoDTO);
        URI uri = createRouteUri(id);
        return ResponseEntity.created(uri).build();
    }
}
