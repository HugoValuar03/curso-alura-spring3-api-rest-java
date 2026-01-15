package med.voll.api.domain.paciente;

import jakarta.validation.constraints.NotNull;
import med.voll.api.domain.endereco.DadosEndereco;

import java.util.UUID;

public record DadosAtualizacaoPaciente(
        @NotNull
        UUID id,
        String nome,
        String telefone,
        DadosEndereco endereco
) {
}
