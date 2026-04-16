# 📱 Central de Decisão Acadêmica

Um aplicativo mobile desenvolvido em Flutter que transforma dados brutos do SUAP em **decisão prática para o aluno**.

> O objetivo não é mostrar informação.  
> É responder: **"o que eu preciso fazer agora para não me ferrar?"**

---

# 🎯 Problema

O SUAP possui muitas funcionalidades, mas falha em um ponto crítico:

- Informação descentralizada
- Falta de priorização
- Nenhuma análise de risco
- Não orienta ação

O aluno precisa navegar manualmente para descobrir:

- Se está em risco de reprovação
- Quando estudar
- O que é urgente

---

# 💡 Solução

A Central de Decisão Acadêmica atua como uma **camada inteligente** sobre a API do SUAP.

Ela:

- Agrega dados
- Analisa contexto
- Prioriza ações
- Apresenta decisões claras

---

# 🚀 Funcionalidades

## 🏠 Dashboard (principal)

- Alertas críticos
- Aulas do dia
- Status das disciplinas
- Ações rápidas

---

## 📚 Disciplinas

- Lista de matérias
- Nota atual
- Frequência
- Indicador de risco

---

## 📖 Detalhe da Disciplina

- Desempenho
- Avaliações
- Materiais
- Histórico
- Análise de risco

---

## 🔔 Alertas

- Classificação por prioridade:
  - 🔴 Crítico
  - 🟡 Atenção
  - 🟢 Informativo
- Ordenação automática
- Marcar como resolvido

---

## 📅 Agenda

- Visualização semanal
- Provas, aulas e trabalhos
- Organização temporal

---

## 📨 Inbox Acadêmica

- Mensagens
- Materiais
- Avisos centralizados

---

# 🧠 Diferencial

Este projeto não é um cliente da API.

Ele implementa uma **camada de inteligência** que:

- Detecta risco de reprovação
- Calcula urgência
- Prioriza tarefas
- Gera alertas automáticos

Exemplo:

```json
{
  "disciplina": "Estruturas de Dados",
  "risco": "alto",
  "urgencia": "imediata",
  "motivo": "nota baixa + prova próxima"
}
```
