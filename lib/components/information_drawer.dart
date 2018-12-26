import 'package:bloc_learning/providers/information.provider.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class InformationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: 'Information Drawer',
      child: Column(
        children: <Widget>[
          _buildInfoPanel(context),
          Center(),
        ],
      ),
    );
  }

  Widget _buildInfoPanel(BuildContext context) {
    final bloc = InformationProvider.of(context);

    return InformationProvider(
      bloc: bloc,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30.0),
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Information',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          StreamBuilder(
            stream: bloc.infoStream,
            builder: (context, AsyncSnapshot<PackageInfo> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                children: <Widget>[
                  _buildInfoTitle(
                    '${snapshot.data.appName}',
                    subtitle: 'Pre-release Version Number: ${snapshot.data.version}',
                  ),
                  _buildInfoTitle(
                    'Instructions: ',
                    subtitle: 'Double tap on a contribution to open in a Browser',
                  ),
                  _buildInfoTitle(
                    'Author & Application Info: ',
                    subtitle: 'Developed by me. Many thanks for you',
                  ),
                  RaisedButton(
                    child: Text('Check for update'),
                    onPressed: () => _getNewsetRelease(context, snapshot),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTitle(String title, {String subtitle}) {
    return ListTile(
      title: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subtitle ?? '',
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  _getNewsetRelease(BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
    final bloc = InformationProvider.of(context);

    bloc.releses.listen((releases) {
      if (snapshot.data.version.toString() != releases.tagName) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('${snapshot.data.appName}'),
                content: Container(
                  child: Text(
                    'A new version of this application is available. The current version is ${snapshot.data.version} and the new version is ${releases.tagName}',
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Download'),
                    onPressed: () => null,
                  ),
                  FlatButton(
                    child: Text('Close'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('${snapshot.data.appName}'),
                content: Container(
                  child: Text('There is no new version at this time'),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Close'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
        );
      }
    });
  }
}
