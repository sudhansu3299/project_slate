

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database_project/model/tutor.dart';
import 'package:firebase_database_project/model/user.dart';
import 'package:firebase_database_project/notifier/auth_notifier.dart';
import 'package:firebase_database_project/notifier/tutor_notifier.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

login(User user,AuthNotifier authNotifier) async{
    AuthResult authResult= await FirebaseAuth.instance.signInWithEmailAndPassword(email: user.email, password: user.password)
    .catchError((error)=>print(error.hashCode));

    if(authResult!=null){
        FirebaseUser firebaseUser =authResult.user;

        if(firebaseUser!=null){
            print('Log In: ${firebaseUser}');
            authNotifier.setUser(firebaseUser);
        }
    }
}

signup(User user, AuthNotifier authNotifier) async{
    AuthResult authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: user.email, password: user.password)
        .catchError((error)=>print(error.code));

    if(authResult != null){
        UserUpdateInfo updateInfo =UserUpdateInfo();
        updateInfo.displayName =user.displayName;

        FirebaseUser firebaseUser =authResult.user;

        if(firebaseUser !=null){
            await firebaseUser.updateProfile(updateInfo);

            await firebaseUser.reload();

            print('Signup: $firebaseUser');

            FirebaseUser currentUser =await FirebaseAuth.instance.currentUser();
            authNotifier.setUser(currentUser);
        }
    }
}

signout(AuthNotifier authNotifier) async{
    await FirebaseAuth.instance.signOut()
        .catchError((error)=>print(error.code));
    authNotifier.setUser(null);
}

initializeCurrentUser(AuthNotifier authNotifier) async{
    FirebaseUser firebaseUser =await FirebaseAuth.instance.currentUser();

    if(firebaseUser!=null){
        print(firebaseUser);
        authNotifier.setUser(firebaseUser);
    }
}

getTutors(TutorNotifier tutorNotifier)async{
    QuerySnapshot snapshot= await Firestore.instance.collection('Tutors').getDocuments();

    List<Tutor> _tutorList=[];
    snapshot.documents.forEach((document){
    Tutor tutor =Tutor.fromMap(document.data);
    _tutorList.add(tutor);
    });

    tutorNotifier.tutorList = _tutorList;
}

uploadTutorAndImage(Tutor tutor, bool isUpdating,File localFile) async{
    if(localFile!=null){
        print('Uploading Image');

        var fileExtension = path.extension(localFile.path);
        print(fileExtension);

        var uuid = Uuid().v4();

        final StorageReference firebaseStorageRef =FirebaseStorage.instance.ref().child('tutors/images/$uuid$fileExtension');

        await firebaseStorageRef.putFile(localFile).onComplete.catchError((onError){
            print(onError);
            return false;
        });

        String url =await firebaseStorageRef.getDownloadURL();
        print('download url: $url');
        _uploadTutor(tutor, isUpdating,imageUrl: url);
    }else{
        print('...skipping image upload');
        _uploadTutor(tutor, isUpdating);
    }
}

_uploadTutor(Tutor tutor,bool isUpdating,{String imageUrl}) async{
    CollectionReference tutorRef= Firestore.instance.collection('Tutors');

    if(imageUrl !=null){
        tutor.image =imageUrl;
    }

    if(isUpdating){
        tutor.updatedAt = Timestamp.now();

        await tutorRef.document(tutor.id).updateData(tutor.toMap());
        print('updated tutor with id: ${tutor.id}');
    }else{
            tutor.createdAt =Timestamp.now();

            DocumentReference documentRef = await tutorRef.add(tutor.toMap());

            tutor.id =documentRef.documentID;

            print('uploaded tutor successfully:${tutor.toString()}');

            await documentRef.setData(tutor.toMap(),merge: true);
    }
}
