import 'package:bloc_learning/models/rocks.api.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc_learning/blocs/contribution.bloc.dart';

class ContributionProvider extends InheritedWidget {
  final ContributionBloc bloc;

  ContributionProvider({
    Key key,
    ContributionBloc bloc,
    Widget child,
  })  : this.bloc = bloc ??
            ContributionBloc(
              RocksApi(),
            ),
        super(child: child, key: key);

  static ContributionBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(ContributionProvider) as ContributionProvider).bloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
