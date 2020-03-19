

import 'dart:collection';

import 'package:firebase_database_project/model/tutor.dart';
import 'package:flutter/cupertino.dart';

class TutorNotifier with ChangeNotifier{
    List<Tutor> _tutorList=[];
    Tutor _currentTutor;

    UnmodifiableListView<Tutor> get tutorList => UnmodifiableListView(_tutorList);

    Tutor get currentTutor => _currentTutor;

    set tutorList(List<Tutor> tutorList){
        _tutorList= tutorList;
        notifyListeners();
    }

    set currentTutor(Tutor tutor){
        _currentTutor=tutor;
        notifyListeners();
    }
}