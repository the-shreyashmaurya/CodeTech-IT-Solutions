import 'package:flutter/material.dart';
import 'package:quote_of_the_day_app/screens/main_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikedQuotesScreen extends StatefulWidget {
  final SharedPreferences pref;
  const LikedQuotesScreen({super.key, required this.pref});

  @override
  State<LikedQuotesScreen> createState() => _LikedQuotesScreenState();
}

class _LikedQuotesScreenState extends State<LikedQuotesScreen> {
  List<String> savedQuotes = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    savedQuotes = widget.pref.getStringList("savedQuotes") ?? [];
    print(savedQuotes.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.black54, Colors.black45],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white70,
                          size: 35,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: savedQuotes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 20,
                          decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    savedQuotes[index],
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Share.share(savedQuotes[index]);
                                      },
                                      icon: Icon(
                                        Icons.share,
                                        color: Colors.black,
                                        size: 25,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async{
                                        savedQuotes.remove(savedQuotes[index]);
                                        await widget.pref
                                            .setStringList("savedQuotes", savedQuotes);
                                          setState(() {
                                            
                                          });
                                          
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: const Color.fromARGB(
                                            255, 129, 31, 31),
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
