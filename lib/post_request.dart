import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';



class Service extends StatefulWidget {
  static String routeName = "/Service";

  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<Service>  {

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<int> submitSubscription({File file,String filename,String token})async{
    ///MultiPart request
    var request = http.MultipartRequest(
      'POST', Uri.parse("https://ekow07.pythonanywhere.com/predict"),

    );
    Map<String,String> headers={
      "Authorization":"Bearer $token",
      "Content-type": "multipart/form-data"
    };
    request.files.add(
      http.MultipartFile(
        'file',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: filename,
        contentType: MediaType('image','jpeg'),
      ),
    );
    request.headers.addAll(headers);
    request.fields.addAll({
      "name":"test",
      "email":"test@gmail.com",
      "id":"12345"
    });
    print("request: "+request.toString());
    var res = await request.send();
    print("This is response:"+res.toString());
    return res.statusCode;
  }

}






