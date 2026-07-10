import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit(this._authService) : super(AuthInitial());

  Future<void> login(String matricula, String password) async {
    emit(AuthLoading()); // Muda o estado para carregando

    final success = await _authService.login(matricula, password);

    if (success) {
      emit(AuthAuthenticated()); // Sucesso no login
    } else {
      emit(AuthError('Falha na autenticação. Verifique os dados.'));
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    emit(AuthInitial());
  }
}
