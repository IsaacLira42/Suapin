# 📱 Estrutura do App — Central de Decisão Acadêmica

---

# 🏠 1. Dashboard (Home)

# Dashboard

## Objetivo

Responder em 5 segundos:
"O que eu preciso fazer agora?"

---

## Seções

### 🔴 Alertas Críticos

- Lista de problemas prioritários
- Ex:
  - "Prova de POO em 3 dias"
  - "Faltas acima de 20% em BD"
  - "Nota abaixo da média em ED"

---

### 📅 Hoje

- Aulas do dia
  - Disciplina
  - Horário
  - Sala
- Status:
  - Em andamento / Próxima / Finalizada

---

### 📊 Disciplinas (Resumo)

- Nome da disciplina
- Nota atual
- % de faltas
- Indicador visual:
  - Verde (ok)
  - Amarelo (atenção)
  - Vermelho (risco)

---

### ⚡ Ações Rápidas

- Ver materiais
- Ver avaliações
- Criar chamado

---

# 📚 2. Disciplinas

# Disciplinas

## Objetivo

Visão geral de todas as matérias com status claro

---

## Lista de Disciplinas

Cada card contém:

- Nome da disciplina
- Professor
- Nota atual
- Faltas (%)
- Barra de progresso

---

## Interações

- Clique → abre detalhes da disciplina

---

# 📖 3. Detalhe da Disciplina

# Detalhe da Disciplina

## Objetivo

Centralizar tudo de uma matéria

---

## Abas

### 📊 Desempenho

- Nota atual
- Histórico de notas
- Média necessária para aprovação

---

### 📅 Aulas

- Lista de aulas
- Datas e conteúdos

---

### 📝 Avaliações

- Provas e trabalhos
- Datas
- Status:
  - Pendente
  - Concluído

---

### 📂 Materiais

> Talvez eu não coloque

- Lista de materiais
- Botão para abrir/download

---

### ⚠️ Risco

- Status:
  - Baixo / Médio / Alto
- Motivo:
  - Nota baixa
  - Faltas
  - Prova próxima

---

# 🔔 4. Alertas (Tela dedicada)

## Objetivo

Centralizar tudo que exige ação

---

## Tipos de alerta

> Temporariamente retirada

### 🔴 Crítico

- Prova próxima
- Risco de reprovação

### 🟡 Atenção

- Nota baixa
- Frequência subindo

### 🟢 Informativo

- Novo material
- Nova mensagem

---

## Funcionalidades

- Ordenação por prioridade
- Marcar como resolvido

---

# 📅 5. Agenda

## Objetivo

Visualizar tempo e carga acadêmica

---

## Modos

### 📆 Semanal

- Aulas
- Provas
  > Trabalhos foram removidos
- Trabalhos

---

# 📨 6. Mensagens / Materiais (Inbox)

## Objetivo

Unificar informações espalhadas

---

## Tipos

- Mensagens
- Avisos

---

## Funcionalidades

- Marcar como lido
- Filtrar:
  - Não lido
  - Importante

---

# ⚙️ 7. Perfil / Configurações

# Perfil

## Objetivo

Gerenciar conta e integração com SUAP

---

## Segurança

- Logout

> Talvez remova

- Refresh token status
