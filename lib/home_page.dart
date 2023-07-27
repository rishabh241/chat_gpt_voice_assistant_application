import 'package:chat_gpt/ai_service.dart';
import 'package:chat_gpt/feature_class.dart';
import 'package:chat_gpt/pallete.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText= SpeechToText();
  String lastWords = '';
  final OpenAIService aiService = OpenAIService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeechToText();
  }
  Future<void> initSpeechToText() async{
      await speechToText.initialize();
      setState(() {

      });
  }
  /// Each time to start a speech recognition session
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> stopListening() async {
    //

    await speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    speechToText.stop();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Allen "),
        leading: Icon(Icons.menu),
        backgroundColor: Pallete.whiteColor,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  margin: EdgeInsets.only(top: 4),
                  decoration:const BoxDecoration(
                    color: Pallete.assistantCircleColor,
                    shape: BoxShape.circle
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 123,
                  // width: 125,
                  decoration:const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage('assests/images/virtualAssistant.png'))
                  ),
                ),
              )
            ],
          ),
          Container(
            padding:const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            margin: EdgeInsets.symmetric(horizontal: 40).copyWith(
              top: 30,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Pallete.borderColor,
              ),
              borderRadius: BorderRadius.circular(20).copyWith(
                topLeft: Radius.zero,
                bottomRight: Radius.zero
              )
            ),
          child: const Padding(
            padding:  EdgeInsets.symmetric(vertical: 10.0),
            child: Text("Good Morning, what task can I do for you!",
              style: TextStyle(
                color: Pallete.mainFontColor,
                fontSize: 26,
                fontFamily:'Cera-Pro'
              ),),
          ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 50),
            alignment: Alignment.centerLeft,
            child: const Text("Here are a few features",
              style:TextStyle(
                fontSize: 20,
                fontFamily: 'Cera-Pro',
                color: Pallete.mainFontColor,
                fontWeight: FontWeight.bold
            ),
            ),
          ),
          const Column(
            children: [
                // Features(colors: Pallete.firstSuggestionBoxColor),
              Features(colors: Pallete.firstSuggestionBoxColor,
                  headerText: 'ChatGPT',
                  desc: 'A smarter way to stay organized and informed with ChatGPT'
              ),
              Features(colors: Pallete.secondSuggestionBoxColor,
                  headerText: 'ChatGPT',
                  desc: 'A smarter way to stay organized and informed with ChatGPT'
              ),
              Features(colors: Pallete.thirdSuggestionBoxColor,
                  headerText: 'ChatGPT',
                  desc: 'A smarter way to stay organized and informed with ChatGPT'
              )

            ],
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          if(await speechToText.hasPermission && speechToText.isNotListening){
            await startListening();
          }else if(speechToText.isListening){
            await aiService.isArtPrompApi(lastWords);
            print(lastWords);
            await stopListening();
          }else{
            initSpeechToText();
          }
        },
        child: Icon(Icons.mic),
      ),
    );
  }
}
