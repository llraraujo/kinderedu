package com.kinderedu.backend.api;


import com.kinderedu.backend.domain.dto.TurmaCadastroDTO;
import com.kinderedu.backend.domain.entities.Turma;
import com.kinderedu.backend.services.TurmaService;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/turmas")
public class TurmaController  extends BaseController{

    @Autowired
    private TurmaService turmaService;

    @RequestMapping(method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses({@ApiResponse(responseCode = "200")})
    public ResponseEntity<List<Turma>> index() {
        var turmas = turmaService.todasAsTurmas();
        return ResponseEntity.ok(turmas);
    }

    @RequestMapping(method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses({@ApiResponse(responseCode = "201")})
    public ResponseEntity create(@RequestBody TurmaCadastroDTO turmaCadastroDTO){
        Turma turma = this.turmaService.create(turmaCadastroDTO);
        URI uri = createRouteUri(turma.getIdTurma());
        return ResponseEntity.created(uri).build();
    }

}
