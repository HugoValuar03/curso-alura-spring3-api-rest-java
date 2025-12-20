package med.voll.api.controller;

import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import med.voll.api.medico.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/medicos")
public class MedicoController {

    @Autowired
    private MedicoRepository repository;

    @PostMapping
    @Transactional
    public void cadastrar(@RequestBody @Valid DadosCadastroMedico dados) {
        repository.save(new Medico(dados));
    }

    @GetMapping
    public Page<DadosListagemMedico> listar(@PageableDefault(size = 10, sort = {"nome"}) Pageable paginacao) { //@PagealeDefault cria padrões caso não seja informado na url
        return repository.findAll(paginacao).map(DadosListagemMedico::new); //Converte uma lista de médicos para uma lista de DadosListagemMedico
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
    public void atualizar(@RequestBody @Valid DadosAtualizacaoMedico dados) {
        var medico = repository.getReferenceById(dados.id());
        medico.atualizarInformacoes(dados);
    }

}
