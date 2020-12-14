import 'package:baraka/models/changed-location.dart';
import 'package:flutter/material.dart';

import 'bloc_state.dart';

class MapBloc extends GeneralBlocState {
  bool _isMapCreated = false;
  ChangedLocation _changedLocation;
  bool get isMapCreated => _isMapCreated;
  ChangedLocation get changedLocation => _changedLocation;
  setIsMapCreated({bool val}) {
    _isMapCreated = val;
    notifyListeners();
  }

  setChangedLocation({@required ChangedLocation location}) {
    _changedLocation = location;
    notifyListeners();
  }
}
