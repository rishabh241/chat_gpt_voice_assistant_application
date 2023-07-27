import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:chat_gpt/secret.dart';
class OpenAIService{
  Future<String> isArtPrompApi(String prompt)async{
    try{
      // return 'ram';
     final res = await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
       headers:{
         'Content-Type': 'application/json',
         'Authorization': 'Bearer $openAIApiKey',
       },
       body: jsonEncode({
         "model": "gpt-3.5-turbo",
         "messages":[{
           'role':'user',
           'content':'Does this message want to generate the image or artwork or anything similar $prompt,simply answer yes or no',

         }

         ]
         })
      );
     print(res.body);
     if(res.statusCode==200){
       print("yes");
     }
     return "Ram";
    }catch(e){
      return e.toString();
    }
  }
  Future<String> chatGptApi(String prompt)async{
    return 'ChatGpt';
  }
  Future<String> dallEApi(String prompt)async{
    return 'Dall-E';
  }
}