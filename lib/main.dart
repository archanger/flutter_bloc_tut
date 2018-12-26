import 'package:bloc_learning/blocs/contribution.bloc.dart';
import 'package:bloc_learning/models/model.dart';
import 'package:bloc_learning/models/rocks.api.dart';
import 'package:bloc_learning/providers/contribution.provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContributionProvider(
      bloc: ContributionBloc(RocksApi()),
      child: RootApp(),
    );
  }
}

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = ContributionProvider.of(context);

    return MaterialApp(
      title: 'Utopian Rocks Mobile',
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Utopian Rocks Mobile'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.rate_review),
                  text: 'Waiting for review',
                ),
                Tab(
                  icon: Icon(Icons.hourglass_empty),
                  text: 'Waiting to Upvote',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ListPage(
                pageName: 'unreviewed',
                bloc: bloc,
              ),
              ListPage(
                pageName: 'pending',
                bloc: bloc,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
