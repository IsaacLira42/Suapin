# SUAP API Documentation

**Version:** 1.0.0  
**OpenAPI:** OAS 3.1  
**Base URL:** `/api`  
**Spec File:** `/api/openapi.json`  
**Authentication:** Token (Authorize)

---

## Authentication Endpoints

| Method | Endpoint             | Description   |
| ------ | -------------------- | ------------- |
| POST   | `/api/token/pair`    | Obtain Token  |
| POST   | `/api/token/refresh` | Refresh Token |
| POST   | `/api/token/verify`  | Verify Token  |

---

## Gestão de Pessoas (People Management)

| Method | Endpoint                                                 | Description                   |
| ------ | -------------------------------------------------------- | ----------------------------- |
| GET    | `/api/rh/meus-dados/`                                    | My personal profile           |
| GET    | `/api/rh/eu/`                                            | My personal data              |
| GET    | `/api/rh/unidades-organizacionais/`                      | Campi                         |
| GET    | `/api/rh/servidores/`                                    | Employees                     |
| GET    | `/api/rh/servidores_funcao_ativa/`                       | Employees with active role    |
| GET    | `/api/rh/servidores/detalhado/`                          | Detailed employee data        |
| GET    | `/api/rh/servidores/integra/`                            | Employee data (integra scope) |
| GET    | `/api/rh/setores/`                                       | Sectors                       |
| GET    | `/api/rh/meu-historico-funcional/`                       | My functional history         |
| GET    | `/api/rh/minhas-ocorrencias-afastamentos/`               | My absences                   |
| GET    | `/api/rh/emitir-carteira-funcional-digital/{matricula}/` | Digital functional ID card    |
| GET    | `/api/rh/minhas-ferias/`                                 | My vacations                  |
| GET    | `/api/rh/minhas-frequencias/`                            | My daily attendance           |
| GET    | `/api/rh/servidor-resumido/`                             | Summarized employee data      |
| GET    | `/api/rh/meus-contracheques/`                            | My paychecks (list)           |
| GET    | `/api/rh/meu-contracheque/{ano}/{mes}/`                  | My detailed paycheck          |
| GET    | `/api/rh/contracheques/`                                 | All paychecks                 |

---

## Ensino (Teaching)

### General

| Method | Endpoint                             | Description         |
| ------ | ------------------------------------ | ------------------- |
| GET    | `/api/ensino/periodos/`              | Academic periods    |
| GET    | `/api/ensino/meus-periodos-letivos/` | My academic periods |

### Diaries & Classes

| Method | Endpoint                                               | Description        |
| ------ | ------------------------------------------------------ | ------------------ |
| GET    | `/api/ensino/diarios/{semestre}/`                      | Diaries            |
| GET    | `/api/ensino/diarios/{id_diario}/professores/`         | Teachers           |
| GET    | `/api/ensino/diarios/{id_diario}/alunos/`              | Students           |
| GET    | `/api/ensino/diarios/{id_diario}/aulas/`               | Classes            |
| GET    | `/api/ensino/diarios/{id_diario}/materiais/`           | Materials          |
| GET    | `/api/ensino/materiais/{id_material}/`                 | Material details   |
| GET    | `/api/ensino/materiais/{id_diario}/{id_material}/pdf/` | Material PDF       |
| GET    | `/api/ensino/diarios/{id_diario}/trabalhos/`           | Assignments        |
| GET    | `/api/ensino/trabalhos/{id_trabalho}/`                 | Assignment details |
| GET    | `/api/ensino/diarios/{id_diario}/topicos/`             | Topics             |

### Student

| Method | Endpoint                                                 | Description             |
| ------ | -------------------------------------------------------- | ----------------------- |
| GET    | `/api/ensino/meus-dados-aluno/`                          | My student data         |
| GET    | `/api/ensino/aluno-resumido/`                            | Summarized student data |
| GET    | `/api/ensino/aluno-matriculado/`                         | Enrolled student        |
| GET    | `/api/ensino/meu-boletim/{ano_letivo}/{periodo_letivo}/` | Report card             |
| GET    | `/api/ensino/requisitos-conclusao/`                      | Graduation requirements |
| GET    | `/api/ensino/minhas-proximas-avaliacoes/`                | Upcoming exams          |
| GET    | `/api/ensino/disciplinas/{semestre}/`                    | Subjects                |
| GET    | `/api/ensino/disciplinas/{disciplina}/etapas/`           | Assessments             |

### Teacher

| Method | Endpoint                                                  | Description     |
| ------ | --------------------------------------------------------- | --------------- |
| GET    | `/api/ensino/meus-diarios/`                               | My open diaries |
| GET    | `/api/ensino/meus-diarios/{ano_letivo}/{periodo_letivo}/` | My diaries      |
| GET    | `/api/ensino/portal-professores/`                         | Teacher Portal  |

### Virtual Classes

| Method | Endpoint                                                            | Description           |
| ------ | ------------------------------------------------------------------- | --------------------- |
| GET    | `/api/ensino/minha-turma-virtual/{pk}/`                             | Virtual class details |
| GET    | `/api/ensino/minhas-turmas-virtuais/{ano_letivo}/{periodo_letivo}/` | My virtual classes    |
| GET    | `/api/ensino/meus-diarios-ead/`                                     | My EAD diaries (list) |
| GET    | `/api/ensino/meus-diarios-ead/{pk}/`                                | My EAD diary details  |

### Messages

| Method | Endpoint                                                 | Description     |
| ------ | -------------------------------------------------------- | --------------- |
| GET    | `/api/ensino/mensagens/entrada/{status}/`                | My messages     |
| POST   | `/api/ensino/mensagens/registro-leitura/{mensagem_id}/`  | Mark as read    |
| DELETE | `/api/ensino/mensagens/registro-exclusao/{mensagem_id}/` | Mark as deleted |

### Guardian Authentication

| Method | Endpoint                                        | Description                            |
| ------ | ----------------------------------------------- | -------------------------------------- |
| POST   | `/api/ensino/autenticacao/acesso-responsaveis/` | Authenticate guardian of minor student |

---

## Tecnologia da Informação (IT)

### Digital Counter

| Method   | Endpoint                                                                          | Description                   |
| -------- | --------------------------------------------------------------------------------- | ----------------------------- |
| GET      | `/api/ti/balcao-digital/`                                                         | List all active services      |
| GET      | `/api/ti/balcao-digital/{id_servico_portal_govbr}/`                               | Specific active service       |
| GET      | `/api/ti/balcao-digital/cpf/{cpf}/`                                               | Services available for user   |
| GET      | `/api/ti/balcao-digital/cpf/{cpf}/avaliacao_disponibilidade/`                     | Service availability for user |
| POST     | `/api/ti/balcao-digital/autocompletar/`                                           | Autocomplete search           |
| POST/GET | `/api/ti/balcao-digital/{id_servico_portal_govbr}/cpf/{cpf}/receber_solicitacao/` | Submit request                |
| GET      | `/api/ti/balcao-digital/cpf/{cpf}/acompanhamentos/`                               | Track requests                |

### Updates

| Method | Endpoint                     | Description  |
| ------ | ---------------------------- | ------------ |
| GET    | `/api/ti/atualizacoes-suap/` | SUAP updates |

---

## Comunicação Social (Social Communication)

| Method | Endpoint                               | Description    |
| ------ | -------------------------------------- | -------------- |
| GET    | `/api/midia/banners/`                  | Active banners |
| GET    | `/api/midia/eventos/ativos-deferidos/` | Events         |

---

## Administração (Administration)

| Method | Endpoint                                                      | Description               |
| ------ | ------------------------------------------------------------- | ------------------------- |
| GET    | `/api/administracao/meus-processos-fisicos/`                  | My physical processes     |
| GET    | `/api/administracao/meu-processo-fisico/{pk}/`                | Detailed physical process |
| GET    | `/api/administracao/validar-visitante-portaria/{chave_wifi}/` | Validate Wi-Fi key        |
| GET    | `/api/administracao/terceirizados/`                           | Active outsourced workers |

---

## Pesquisa (Research)

| Method | Endpoint                  | Description       |
| ------ | ------------------------- | ----------------- |
| GET    | `/api/pesquisa/projetos/` | Research projects |

---

## Gestão Institucional (Institutional Management)

| Method | Endpoint                                          | Description                 |
| ------ | ------------------------------------------------- | --------------------------- |
| GET    | `/api/institucional/estatisticas/`                | SUAP statistics             |
| GET    | `/api/institucional/consulta_publica/documentos/` | Public electronic documents |

---

## Extensão (Extension)

| Method | Endpoint                  | Description        |
| ------ | ------------------------- | ------------------ |
| GET    | `/api/extensao/projetos/` | Extension projects |
