import 'package:bloc_learning/models/github.api.dart';
import 'package:bloc_learning/models/model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:package_info/package_info.dart';

class InformationBloc {
  final Future<PackageInfo> _packageInfo;
  final GithubApi _api;

  Stream<PackageInfo> _infoStream = Stream.empty();
  Stream<GithubModel> _releases = Stream.empty();

  InformationBloc(this._packageInfo, this._api) {
    _releases = Observable.defer(
      () => Observable.fromFuture(_api.getReleases()).asBroadcastStream(),
      reusable: true,
    );

    _infoStream = Observable.defer(
      () => Observable.fromFuture(_packageInfo).asBroadcastStream(),
      reusable: true,
    );
  }

  Stream<PackageInfo> get infoStream => _infoStream;
  Stream<GithubModel> get releses => _releases;
}
