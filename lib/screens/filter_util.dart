import 'package:cloud_firestore/cloud_firestore.dart';

class FilterUtil{
  getFilterSearch(List<String> category){
    
    return Firestore.instance
          .collection('Tutors')
          .where('details', arrayContainsAny: category)
          .orderBy('updatedAt', descending: true)
          .getDocuments();
  }
}