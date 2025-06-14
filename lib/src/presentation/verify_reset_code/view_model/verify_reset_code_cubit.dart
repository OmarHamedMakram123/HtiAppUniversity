import 'package:bloc/bloc.dart';
import 'package:hti_univerity/src/presentation/verify_reset_code/view_model/verify_reset_code_action.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/network/common/result.dart';
import '../../../data/model/request/verify_reset_code_request/verify_reset_code_request.dart';
import '../../../domain/entities/success_auth_entity.dart';
import '../../../domain/use_case/auth_use_case/verify_reset_code_use_case.dart';

part 'verify_reset_code_state.dart';

@injectable
class VerifyResetCodeCubit extends Cubit<VerifyResetCodeState> {
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  VerifyResetCodeCubit(this._verifyResetCodeUseCase)
      : super(VerifyResetCodeInitial());

  Future<void> doAction(VerifyResetCodeAction verifyRestCodeAction) async {
    switch (verifyRestCodeAction) {
      case VerifyResetCompletedAction():
        return await _setResetCode(resetCode: verifyRestCodeAction.value);
      case NavigateToResetPasswordAction():
        return _navigateToResetPasswordScreen();
    }
  }


  Future<void> _setResetCode({String? resetCode}) async {
    if (resetCode != null && resetCode.isNotEmpty && resetCode.length >= 6) {
      return await _verifyResetCode(resetCode: resetCode);
    } else {
      return;
    }
  }

  String email="";

  Future<void> _verifyResetCode({required String resetCode}) async {
    VerifyResetCodeRequest verifyResetCodeRequest =
        VerifyResetCodeRequest(resetCode: resetCode);
    emit(VerifyCodeLoadingStata());
    var result = await _verifyResetCodeUseCase.invoke(
        verifyResetCodeRequest: verifyResetCodeRequest);
    switch (result) {
      case Success<SuccessAuthEntity>():
        emit(VerifyCodeSuccessStata(massage: result.data.massage ?? "Success"));
      case Failures<SuccessAuthEntity>():
        emit(VerifyCodeErrorStata(errorMassage: ""));
    }
  }

  void _navigateToResetPasswordScreen() {
    emit(NavigateToResetPasswordScreenState());
  }
}
