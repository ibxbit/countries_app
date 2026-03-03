import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_country_detail.dart';
import 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  final GetCountryDetail getCountryDetail;

  DetailCubit({required this.getCountryDetail}) : super(DetailInitial());

  Future<void> loadCountryDetail(String code) async {
    emit(DetailLoading());
    final result = await getCountryDetail(code);
    result.fold(
      (failure) => emit(DetailError(failure.message)),
      (country) => emit(DetailLoaded(country)),
    );
  }
}
