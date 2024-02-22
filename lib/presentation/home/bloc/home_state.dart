part of 'home_bloc.dart';

class HomeState extends Equatable {
  final HomeStateEnum homeStateEnum;
  final CountData? countData;

  const HomeState({this.homeStateEnum = HomeStateEnum.initial, this.countData});

  HomeState copyWith({HomeStateEnum? homeStateEnum, CountData? countData}) {
    return HomeState(
        homeStateEnum: homeStateEnum ?? this.homeStateEnum, countData: countData ?? this.countData);
  }

  @override
  List<Object?> get props => [homeStateEnum, countData];
}

enum HomeStateEnum { initial, signedOut, fail, getCountCheckListSuccess }

extension HomeStateX on HomeStateEnum {
  bool get initial => this == HomeStateEnum.initial;

  bool get signedOut => this == HomeStateEnum.signedOut;

  bool get fail => this == HomeStateEnum.fail;

  bool get getCountCheckListSuccess => this == HomeStateEnum.getCountCheckListSuccess;
}
