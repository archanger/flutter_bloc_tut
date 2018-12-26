import 'package:bloc_learning/models/model.dart';
import 'package:bloc_learning/models/rocks.api.dart';
import 'package:rxdart/rxdart.dart';

class ContributionBloc {
  final RocksApi _rocksApi;

  Stream<List<Contribution>> _results = Stream.empty();

  BehaviorSubject<String> _pageName = BehaviorSubject(seedValue: 'unreviewed');

  ContributionBloc(this._rocksApi) {
    _results = _pageName.asyncMap((page) => _rocksApi.getContributions(pageName: page)).asBroadcastStream();
  }

  dispose() {
    _pageName.close();
  }

  Stream<List<Contribution>> get results => _results;

  Sink<String> get pageName => _pageName;
}
