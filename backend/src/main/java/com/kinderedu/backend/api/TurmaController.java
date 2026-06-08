package com.kinderedu.backend.api;


import com.kinderedu.backend.domain.entities.Turma;
import com.kinderedu.backend.services.TurmaService;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/turmas")
public class TurmaController {

    @Autowired
    private TurmaService turmaService;

    @RequestMapping(method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses({@ApiResponse(responseCode = "200")})
    public ResponseEntity<List<Turma>> getAll() {
        var turmas = turmaService.todasAsTurmas();
        return ResponseEntity.ok(turmas);
    }
}
