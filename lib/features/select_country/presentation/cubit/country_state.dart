part of 'country_cubit.dart';

sealed class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object> get props => [];
}

class CountryInitial extends CountryState {}

class CountriesChangeLoadingState extends CountryState {}

class CountriesChangeSuccessState extends CountryState {}

class CountriesLoadingState extends CountryState {}

class CountriesSuccessState extends CountryState {
  const CountriesSuccessState();
}

class CountriesErrorState extends CountryState {
  final String error;

  const CountriesErrorState(this.error);
}
