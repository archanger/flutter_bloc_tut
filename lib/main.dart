import 'package:bloc_learning/blocs/contribution.bloc.dart';
import 'package:bloc_learning/components/information_drawer.dart';
import 'package:bloc_learning/components/list_page.dart';
import 'package:bloc_learning/models/rocks.api.dart';
import 'package:bloc_learning/providers/contribution.provider.dart';
import 'package:bloc_learning/providers/information.provider.dart';
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
          endDrawer: InformationProvider(
            child: InformationDrawer(),
          ),
        ),
      ),
    );
  }
}
