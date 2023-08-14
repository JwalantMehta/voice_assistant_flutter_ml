import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_assistant_flutter_ml/feature_box.dart';
import 'package:voice_assistant_flutter_ml/openai_service.dart';
import 'package:voice_assistant_flutter_ml/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  String lastWords = "";
  OpenAIService openAIService = OpenAIService();
  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    // speechEnabled = await speechToText.initialize();
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
    await speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
      setState(() {
        lastWords = result.recognizedWords;
        print(lastWords);
      });
  }
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CosmicAI"),
        centerTitle: true,
        leading: const Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //virtual assistant picture
            Stack(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 4),
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Pallete.assistantCircleColor,
                    ),
                  ),
                ),
                Container(
                  height: 123,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/virtualAssistant.png"),
                    ),
                  ),
                )
              ],
            ),
            //virtual assistant picture ends

            //chat Bubble
            Container(
              padding: const EdgeInsets.only(
                  top: 10.0, right: 20.0, left: 20.0, bottom: 10.0),
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Pallete.borderColor),
                  borderRadius: BorderRadius.circular(20).copyWith(
                    topLeft: Radius.zero,
                  )),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Hello Sir, what task can I do for you?",
                  style: TextStyle(
                    fontFamily: "Cera Pro",
                    color: Pallete.mainFontColor,
                    fontSize: 25,
                  ),
                ),
              ),
            ),

            //few feature text:-

            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 40),
              child: const Text(
                "Here are a few features!",
                style: TextStyle(
                    fontFamily: "Cera Pro",
                    color: Pallete.mainFontColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),

            // features list:-
            const Column(
              children: [
                FeatureBox(
                    color: Pallete.firstSuggestionBoxColor,
                    headerText: "ChatGPT",
                    descriptionText: "A smarter way to stay updated with chatGPT"
                ),
                FeatureBox(
                    color: Pallete.secondSuggestionBoxColor,
                    headerText: "Dall-E",
                    descriptionText: "Get inspired and stay creative with your personal assistant"
                ),
                FeatureBox(
                    color: Pallete.thirdSuggestionBoxColor,
                    headerText: "Smart Voice Assistant",
                    descriptionText: "Get the best out of both world with a voice assistant powered by Dall-E and chatGPT"
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if(await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
            print("listening");
          }
          else if(speechToText.isListening) {
            await openAIService.isArtPromptAPI(lastWords);
            await stopListening();
            print("stopped listening");
          }
          else{
            initSpeechToText();
            print("permissions not granted");
          }
        },
        child: const Icon(Icons.mic),
      ),
    );
  }
}
