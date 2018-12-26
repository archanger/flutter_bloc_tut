import 'package:bloc_learning/blocs/information.bloc.dart';
import 'package:bloc_learning/models/github.api.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info/package_info.dart';

class InformationProvider extends InheritedWidget {
  final InformationBloc _bloc;

  InformationProvider({
    Key key,
    Widget child,
    InformationBloc bloc,
  })  : _bloc = bloc ??
            InformationBloc(
              PackageInfo.fromPlatform(),
              GithubApi(),
            ),
        super(
          key: key,
          child: child,
        );

  static InformationBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(InformationProvider) as InformationProvider)._bloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
