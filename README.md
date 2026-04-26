# 🐸 Suapin

O Suapin é um projeto desenvolvido para a disciplina de Desenvolvimento de Dispositivos Móveis. Trata-se de um aplicativo construído em Flutter que consome a API do SUAP (via um backend em Django) para atuar como uma camada de suporte à decisão. O foco do projeto é converter o volume de dados acadêmicos brutos em informações acionáveis, auxiliando o aluno no monitoramento de desempenho e na gestão de riscos de reprovação.

---

## 🎨 Interface e Design (Figma)

O design da interface e o fluxo do usuário foram projetados para priorizar a clareza e a rapidez na tomada de decisão.

> ### 🔗 **[Acessar Protótipo Interativo no Figma](https://www.figma.com/design/LqyZWxuVsuQackQrFQGPBX/Suapin?node-id=0-1&p=f)**

## 🛠️ Stack Tecnológica

<img src="https://skillicons.dev/icons?i=flutter,dart,docker,git,figma" height="52"/>

## 🎯 Problema

O SUAP possui muitas funcionalidades, mas falha em um ponto crítico para a experiência do estudante:

- **Informação descentralizada:** Dados espalhados em diversas abas e menus.
- **Falta de priorização:** O sistema não diz o que é mais importante no momento.
- **Ausência de análise de risco:** O aluno não sabe, de forma imediata, sua real situação de perigo.
- **Passividade:** O sistema mostra o dado, mas não orienta a ação necessária.

## 💡 Solução

A **Central de Decisão Acadêmica** atua como uma **camada inteligente** sobre a API do SUAP. Ela não é apenas um leitor de dados; ela filtra, analisa e prioriza o que realmente importa para a sobrevivência acadêmica.

- **Agrega dados:** Consolida informações de múltiplas fontes.
- **Analisa contexto:** Cruza datas, notas e frequências.
- **Prioriza ações:** Mostra o que é urgente primeiro.
- **Apresenta decisões claras:** Sugere o próximo passo lógico.

## 🚀 Funcionalidades

### 🏠 Dashboard (Principal)

O centro de controle do aluno. Exibe alertas críticos, as próximas aulas do dia, um resumo do status das disciplinas e atalhos para ações rápidas.

### 📚 Disciplinas & Detalhes

Lista completa de matérias com indicadores visuais de desempenho. Ao detalhar, o aluno tem acesso a:

- Histórico de avaliações e materiais.
- **Indicador de Risco:** Uma métrica visual que mostra a probabilidade de reprovação baseada no desempenho atual.

### 🔔 Alertas Inteligentes

Notificações classificadas por severidade para evitar surpresas:

- 🔴 **Crítico:** Risco iminente de reprovação ou prazo expirando hoje.
- 🟡 **Atenção:** Notas abaixo da média ou entrega de trabalhos próxima.
- 🟢 **Informativo:** Novos materiais postados ou avisos gerais.

### 📅 Agenda & Inbox

Visualização temporal de provas e trabalhos integrada a uma caixa de entrada centralizada para mensagens e avisos acadêmicos.

## 🏗️ Arquitetura do Projeto

O projeto adota os princípios da **Clean Architecture**, garantindo que a lógica de decisão seja independente de fatores externos.

### Camadas do Sistema (Flutter)

1.  **Domain (Coração):** Contém as `Entities` (objetos puros) e os `UseCases`. É aqui que reside a lógica de cálculo de risco e priorização.
2.  **Data (Infraestrutura):** Implementa os `Repositories` e `DataSources`. Gerencia a comunicação com a API Django e o cache local.
3.  **Presentation (Interface):** Camada focada em UI e Gerenciamento de Estado, consumindo diretamente os casos de uso.

### Estrutura de Pastas

```text
lib/
├── core/              # Config. de rede, constantes e utils
├── data/              # Camada de Dados
│   ├── models/        # Mapeamento JSON/Dart (DTO)
│   ├── providers/     # Chamadas diretas à API (Dio)
│   └── repositories/  # Implementações dos contratos de dados
├── domain/            # Camada de Negócio
│   ├── entities/      # Objetos de negócio (Disciplina, Alerta)
│   ├── repositories/  # Interfaces/Contratos (Abstração)
│   └── usecases/      # Regras de Decisão
└── presentation/      # Camada de UI
    ├── pages/         # Telas do aplicativo
    ├── widgets/       # Componentes reutilizáveis
    └── controller/    # Gerenciamento de estado
```

## 🧠 O Diferencial: Camada de Inteligência

Este projeto implementa uma lógica que transforma JSON bruto em insights acionáveis.

**Exemplo de processamento interno:**

```json
// O que o app processa internamente para o usuário
{
  "disciplina": "Estruturas de Dados",
  "status_analisado": {
    "risco": "ALTO",
    "urgencia": "IMEDIATA",
    "motivo": "Nota atual (4.0) exige 8.5 na próxima avaliação para evitar exame final.",
    "sugestao": "Focar nos materiais de 'Árvores Binárias' postados ontem."
  }
}
```

## 🛠️ Tecnologias

- **Frontend:** Flutter
- **Backend de Abstração:** Django (REST Framework)
- **Comunicação:** Dio (HTTP Client)
- **Segurança:** JWT (JSON Web Token)
