import 'package:bloc_learning/blocs/contribution.bloc.dart';
import 'package:bloc_learning/models/model.dart';
import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  final ContributionBloc _bloc;
  final String _pageName;

  const ListPage({
    Key key,
    ContributionBloc bloc,
    String pageName,
  })  : _bloc = bloc,
        _pageName = pageName,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    _bloc.pageName.add(_pageName);

    return StreamBuilder(
      stream: _bloc.results,
      builder: (context, AsyncSnapshot<List<Contribution>> snapshot) {
        if (snapshot.hasData == false) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) => ListTile(
                title: Text('${snapshot.data[index].title}'),
              ),
        );
      },
    );
  }
}
