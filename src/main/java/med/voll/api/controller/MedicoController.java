package med.voll.api.controller;

import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import med.voll.api.medico.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;

@RestController
@RequestMapping("/medicos")
public class MedicoController {

    @Autowired
    private MedicoRepository repository;

    @PostMapping
    @Transactional
    public ResponseEntity cadastrar(@RequestBody @Valid DadosCadastroMedico dados, UriComponentsBuilder uriBuilder) {
        var medico = new Medico(dados);
        repository.save(medico);

        var uri = uriBuilder.path("/medicos/{id}").buildAndExpand(medico.getId()).toUri();

        return ResponseEntity.created(uri).body(new DadosDetalhamentoMedico(medico));
    }

    @GetMapping
    public ResponseEntity<Page<DadosListagemMedico>> listar(@PageableDefault(size = 10, sort = {"nome"}) Pageable paginacao) { //@PagealeDefault cria padrões caso não seja informado na url
        var page = repository.findAllByAtivoTrue(paginacao).map(DadosListagemMedico::new); //Converte uma lista de médicos para uma lista de DadosListagemMedico
        return ResponseEntity.ok(page);
    }

    @GetMapping("/{id}")
    public ResponseEntity getById(@PathVariable Long id) {
        var medico = repository.getReferenceById(id);
        return ResponseEntity.ok(new DadosDetalhamentoMedico(medico));
    }

    /*
     * Para controlar quantos registros vem por página, na url após o localhost:8080/medicos, se passa os seguintes parametros:
     * ?size=1 -> Para controlar quantas páginas irão vir
     * Após o ?size=1 pode se passar o page que apresenta a página atual que inicia no 0.
     * Se quiser mostrar a 10 registros e apresentar a segunda página a URL é esta:
     * "localhost:8080/medicos?size=10&page=1"
     */

    /*
     * Para realziar a ordenação, também é pela url
     * Se quiser ordernar por nome do médico, basta passar o nome atributo na entidade jpa, a url seria:
     * -> "localhost:8080/medicos?sort=nome"
     * Se quiser ordernar de forma decrescente:
     * -> "localhost:8080/medicos?sort=nome,desc"
     *
     */

    @PutMapping
    @Transactional
    public ResponseEntity atualizar(@RequestBody @Valid DadosAtualizacaoMedico dados) {
        var medico = repository.getReferenceById(dados.id());
        medico.atualizarInformacoes(dados);

        return ResponseEntity.ok(new DadosDetalhamentoMedico(medico));
    }

    @DeleteMapping("/{id}")
    @Transactional
    public ResponseEntity excluir(@PathVariable Long id) {
        var medico = repository.getReferenceById(id);
        medico.excluir();

        return ResponseEntity.noContent().build();
    }

}
