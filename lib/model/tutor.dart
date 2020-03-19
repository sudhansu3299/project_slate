import 'package:cloud_firestore/cloud_firestore.dart';

class Tutor{
    String id;
    String name;
    String category;
    String image;
    List details;
    Timestamp createdAt;
    Timestamp updatedAt;

    Tutor();

    Tutor.fromMap(Map<String,dynamic> data){
        id= data['id'];
        name= data['name'];
        category =data['category'];
        image=data['image'];
        details =data['details'];
        createdAt =data['createdAt'];
        updatedAt= data['updatedAt'];
    }

    Map<String,dynamic> toMap(){
        return{
          'id':id,
          'name':name,
          'image':image,
          'category':category,
          'details':details,
          'createdAt':createdAt,
          'updatedAt':updatedAt,
        };
    }
}