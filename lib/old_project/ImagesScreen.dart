import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class ImageScreen extends StatelessWidget {

    makeImagesGrid(){
        return GridView.builder(
            itemCount: 5,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context,index){
            return ImageGridItem(index+1);
            });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Images Grid'),
        ),
        body: Container(
            child: makeImagesGrid()
        ),
    );
  }
}

class ImageGridItem extends StatefulWidget {

    int _index;

    ImageGridItem(int index){
        this._index =index;
    }
  @override
  _ImageGridItemState createState() => _ImageGridItemState();
}

class _ImageGridItemState extends State<ImageGridItem> {

    Uint8List imagefile;
    StorageReference photoreference =FirebaseStorage.instance.ref().child('pictures');

    getImage(){
        int MAX_SIZE= 5*1024*1024;
        photoreference.child('image_${widget._index}.jpg').getData(MAX_SIZE).then((data){
            this.setState((){
                imagefile = data;
            });
        }).catchError((error){
            print(error);
        });
    }
    
    Widget decideGridTIle(){
        if(imagefile==null){
            return Center(child: Text('No Data'),);
        }else{
            return Image.memory(imagefile,fit: BoxFit.cover,);
        }
    }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage();
  }
    
    @override
  Widget build(BuildContext context) {
    return GridTile(
        child: decideGridTIle(),
    );
  }
}

