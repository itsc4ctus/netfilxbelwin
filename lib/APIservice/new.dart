import 'dart:convert';

import'package:http/http.dart' as http;

Future<void> sample()async{
  final data ={
    "name":"Rahul",
    "age":30
  };
  
  
  final postData = await http.post(Uri.parse("sample"),body: jsonEncode(data));
  
  
  
}