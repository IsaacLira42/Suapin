import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/anotacao_model.dart';
import '../bloc/anotacoes_cubit.dart';
import '../widgets/base_page.dart';
import '../widgets/titulo_da_pagina.dart';

class AnotacoesPage extends StatelessWidget {
  const AnotacoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnotacoesCubit()..carregarAnotacoes(),
      child: BlocConsumer<AnotacoesCubit, AnotacoesState>(
        listener: (context, state) {
          if (state is AnotacoesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF7F9F9),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xFF065F46),
              onPressed: () => _openAnotacaoSheet(context),
              child: const Icon(Icons.add),
            ),
            body: BasePage(
              currentIndex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TituloDaPagina(
                    titulo: 'Anotações',
                    textoAuxiliar: 'Registros locais do SQLite',
                    usuario: '',
                  ),
                  const SizedBox(height: 16),
                  if (state is AnotacoesLoading)
                    const SizedBox(
                      height: 260,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF065F46),
                        ),
                      ),
                    )
                  else if (state is AnotacoesLoaded)
                    _buildAnotacoesList(context, state.anotacoes)
                  else if (state is AnotacoesError)
                    _buildErrorState(context, state.message)
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnotacoesList(
    BuildContext context,
    List<AnotacaoModel> anotacoes,
  ) {
    if (anotacoes.isEmpty) {
      return SizedBox(
        height: 260,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.note_alt_outlined, size: 56, color: Colors.grey),
              SizedBox(height: 12),
              Text('Nenhuma anotação cadastrada.', textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    }

    final cubit = context.read<AnotacoesCubit>();

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: anotacoes.length,
      separatorBuilder: (context, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final anotacao = anotacoes[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          anotacao.titulo,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          anotacao.disciplina,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () =>
                            _openAnotacaoSheet(context, anotacao: anotacao),
                        icon: const Icon(Icons.edit, color: Color(0xFF065F46)),
                      ),
                      IconButton(
                        onPressed: () async {
                          final shouldDelete = await _confirmDelete(context);
                          if (shouldDelete == true && context.mounted) {
                            await cubit.deletarAnotacao(anotacao.id ?? 0);
                          }
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                anotacao.conteudo,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color(0xFF374151)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return SizedBox(
      height: 260,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 56, color: Colors.red),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () =>
                  context.read<AnotacoesCubit>().carregarAnotacoes(),
              child: const Text('Tentar novamente'),
            ),
            const SizedBox(height: 8),
            const Text(
              // Se uma integração futura com autenticação disparar UnauthorizedException,
              // o redirecionamento para Login pode ser tratado aqui.
              'Se necessário, este é o ponto para tratar um futuro redirecionamento.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openAnotacaoSheet(
    BuildContext context, {
    AnotacaoModel? anotacao,
  }) async {
    final formKey = GlobalKey<FormState>();
    final tituloController = TextEditingController(
      text: anotacao?.titulo ?? '',
    );
    final disciplinaController = TextEditingController(
      text: anotacao?.disciplina ?? '',
    );
    final conteudoController = TextEditingController(
      text: anotacao?.conteudo ?? '',
    );
    final cubit = context.read<AnotacoesCubit>();

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        var isSaving = false;

        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        anotacao == null ? 'Nova anotação' : 'Editar anotação',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: tituloController,
                        decoration: const InputDecoration(
                          labelText: 'Título',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                            ? 'Informe um título'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: disciplinaController,
                        decoration: const InputDecoration(
                          labelText: 'Matéria',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                            ? 'Informe a matéria'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: conteudoController,
                        maxLines: 6,
                        decoration: const InputDecoration(
                          labelText: 'Conteúdo',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                            ? 'Informe o conteúdo'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF065F46),
                          ),
                          onPressed: isSaving
                              ? null
                              : () async {
                                  if (!formKey.currentState!.validate()) {
                                    return;
                                  }

                                  setState(() => isSaving = true);

                                  final model = AnotacaoModel(
                                    id: anotacao?.id,
                                    titulo: tituloController.text.trim(),
                                    disciplina: disciplinaController.text
                                        .trim(),
                                    conteudo: conteudoController.text.trim(),
                                  );

                                  final success = anotacao == null
                                      ? await cubit.adicionarAnotacao(model)
                                      : await cubit.editarAnotacao(model);

                                  if (!sheetContext.mounted) {
                                    return;
                                  }

                                  if (success) {
                                    Navigator.of(sheetContext).pop();
                                  } else {
                                    setState(() => isSaving = false);
                                  }
                                },
                          child: isSaving
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(anotacao == null ? 'Salvar' : 'Atualizar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    tituloController.dispose();
    disciplinaController.dispose();
    conteudoController.dispose();
  }

  Future<bool?> _confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Excluir anotação'),
          content: const Text('Deseja realmente excluir esta anotação?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Excluir', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
