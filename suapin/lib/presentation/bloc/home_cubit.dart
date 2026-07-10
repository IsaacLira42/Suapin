import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/suap_api_service.dart';

// --- ESTADOS ---
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<dynamic> boletim;
  final List<dynamic> avaliacoes;
  final List<dynamic> turmas;

  HomeLoaded({
    required this.boletim,
    required this.avaliacoes,
    required this.turmas,
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

// --- CUBIT ---
class HomeCubit extends Cubit<HomeState> {
  final SuapApiService _apiService;

  HomeCubit(this._apiService) : super(HomeInitial());

  Future<void> carregarDados() async {
    emit(HomeLoading());

    try {
      final data = await _apiService.fetchHomeData();

      emit(
        HomeLoaded(
          boletim: data['boletim'],
          avaliacoes: data['avaliacoes'],
          turmas: data['turmas'],
        ),
      );
    } on UnauthorizedException {
      emit(HomeError('Sessão expirada. Faça login novamente.'));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
