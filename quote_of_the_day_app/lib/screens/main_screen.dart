import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quote_of_the_day_app/screens/liked_quotes_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  final SharedPreferences prefs;
  MainScreen({super.key, required this.prefs});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String quoteText = "";
  bool isLoading = true;
  bool isLiked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuotes();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Container(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

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
                // Menu Button for Liked Quotes
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 10),
                      child: PopupMenuButton(
                        onSelected: (value) {
                          if (value == 'likedQuotes') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LikedQuotesScreen(
                                  pref: widget.prefs,
                                ),
                              ),
                            );
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'likedQuotes',
                            child: Text('Liked Quotes'),
                          ),
                        ],
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white70,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Quotes Starting
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 30,
                        ),
                        child: Image.asset(
                          'images/quote-start.png',
                          color: Colors.white,
                        ),
                      ),

                      // Quotes text

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          quoteText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Jokerman',
                            fontSize: 26,
                            color: Colors.white70,
                          ),
                        ),
                      ),

                      // Quotes Ending
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Image.asset(
                          'images/quote-end.png',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Share and Like Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        if (isLiked == false) {
                          // Get the Saved Quotes List
                          List<String> savedQuotes =
                              widget.prefs.getStringList("savedQuotes") ?? [];

                          // Add the new Quote to the List
                          savedQuotes.add(quoteText);
                          savedQuotes = savedQuotes.reversed.toList();

                          // Save the new Saved Quotes List
                          await widget.prefs
                              .setStringList("savedQuotes", savedQuotes);

                          // Change Liked Icon
                          setState(
                            () {
                              List<String> savedQuotes =
                                  widget.prefs.getStringList("savedQuotes") ??
                                      [];

                              if (savedQuotes.contains(quoteText)) {
                                isLiked = true;
                              } else {
                                isLiked = false;
                              }
                            },
                          );
                        }
                      },
                      icon: isLiked
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 35,
                            )
                          : Icon(
                              Icons.favorite_outline,
                              color: Colors.white70,
                              size: 35,
                            ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    IconButton(
                      onPressed: () {
                        Share.share(quoteText);
                      },
                      icon: Icon(
                        Icons.share_rounded,
                        color: Colors.white70,
                        size: 35,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getQuotes() async {
    Uri quotes_uri = Uri.parse('https://api.adviceslip.com/advice');
    var response = await http.get(
      quotes_uri,
    );

    var result = jsonDecode(response.body);

    setState(() {
      quoteText = result["slip"]["advice"];
      isLoading = false;
    });
  }

  void refreshLike() {
    widget.prefs.getStringList('savedQuotes');
  }
}
