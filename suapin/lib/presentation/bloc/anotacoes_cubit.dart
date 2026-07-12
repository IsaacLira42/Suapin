import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/database/database_helper.dart';
import '../../data/models/anotacao_model.dart';

abstract class AnotacoesState {}

class AnotacoesLoading extends AnotacoesState {}

class AnotacoesLoaded extends AnotacoesState {
  final List<AnotacaoModel> anotacoes;

  AnotacoesLoaded(this.anotacoes);
}

class AnotacoesError extends AnotacoesState {
  final String message;

  AnotacoesError(this.message);
}

class AnotacoesCubit extends Cubit<AnotacoesState> {
  final DatabaseHelper _databaseHelper;

  AnotacoesCubit({DatabaseHelper? databaseHelper})
    : _databaseHelper = databaseHelper ?? DatabaseHelper(),
      super(AnotacoesLoading());

  Future<void> carregarAnotacoes() async {
    emit(AnotacoesLoading());

    try {
      final anotacoes = await _databaseHelper.queryAll();
      emit(AnotacoesLoaded(anotacoes));
    } catch (e) {
      emit(AnotacoesError('Não foi possível carregar as anotações.'));
    }
  }

  Future<bool> adicionarAnotacao(AnotacaoModel anotacao) async {
    try {
      await _databaseHelper.insert(anotacao);
      await carregarAnotacoes();
      return true;
    } catch (e) {
      emit(AnotacoesError('Não foi possível adicionar a anotação.'));
      return false;
    }
  }

  Future<bool> editarAnotacao(AnotacaoModel anotacao) async {
    try {
      await _databaseHelper.update(anotacao);
      await carregarAnotacoes();
      return true;
    } catch (e) {
      emit(AnotacoesError('Não foi possível editar a anotação.'));
      return false;
    }
  }

  Future<bool> deletarAnotacao(int id) async {
    try {
      await _databaseHelper.delete(id);
      await carregarAnotacoes();
      return true;
    } catch (e) {
      emit(AnotacoesError('Não foi possível excluir a anotação.'));
      return false;
    }
  }
}
