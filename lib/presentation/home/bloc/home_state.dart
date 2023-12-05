part of 'home_bloc.dart';

class HomeState extends Equatable {
  final HomeStateEnum homeStateEnum;
  const HomeState({this.homeStateEnum = HomeStateEnum.initial});

  HomeState copyWith({
    HomeStateEnum? homeStateEnum,
  }) {
    return HomeState(homeStateEnum: homeStateEnum ?? this.homeStateEnum);
  }

  @override
  List<Object?> get props => [];

}


enum HomeStateEnum  {initial, signedOut, fail}

extension HomeStateX on HomeStateEnum {
  bool get initial => this == HomeStateEnum.initial;
  bool get signedOut => this == HomeStateEnum.signedOut;
  bool get fail => this == HomeStateEnum.fail;
}