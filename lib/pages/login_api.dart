import 'dart:convert';
import 'package:app_flutter/pages/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class LoginApi{
  static Future<Usuario> login(String user, 
                               String password) async {



var prefs = await SharedPreferences.getInstance();
String token = (prefs.getString("tokenjwt"));

print("token jwt : $token");

var header = {"Content-Type" : "application/json",
              "Authorization" : "Bearer $token"
              };


var url = 
'http://172.26.10.66:50360/api/usuarios';


Map params = {
  "username" : user,
  "senha" : password,
  "email" : user
};

var usuario;



var _body = json.encode(params);

var response = await http.post(url, headers:header, 
                              body: _body);


  Map mapResponse = json.decode(response.body);

    if(response.statusCode == 200){    
      usuario = Usuario.fromJson(mapResponse);
      prefs.setString("tokenjwt", mapResponse["token"]);
    }else{
      usuario = null;
    }  
      return usuario;    
    
  }

}