
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testproject/article.dart';
import 'package:testproject/database_service.dart';

import 'navigation_drawer.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage() : super();
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  List<Article> articles = [];
  late Article article;
  var listedArticles = [];
  var colors = [Colors.green[50], Colors.green[100]];
  var currentColor = 0;

  void _removeArticle(int index) {
    setState(() {
      article = articles.removeAt(index);
      listedArticles.add(article);
    });
  }

  getArticles() async {
    articles = await DatabaseServices.getArticles();
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('Article Page'),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          currentColor = (currentColor == 0) ? 1 : 0;
          return Container(
            color: colors[currentColor],
            child: Dismissible (
              confirmDismiss: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  return showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Are you sure?'),
                        content: Text('Do you want to remove this article?'),
                        actions: <Widget>[
                          TextButton (
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                          TextButton(
                            child: Text('Remove'),
                            onPressed: () {
                              _removeArticle(index);
                              Navigator.of(context).pop(true);
                              setState(() {});
                            },
                          ),
                        ],
                      );
                    }
                  );
                } else {
                  // create SnackBar to show success message  and then remove the item from the list
                  var dismiss = Future.value(true);
                  _removeArticle(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 5),
                      content: const Text('Article added to your list'),
                      action: SnackBarAction(
                        label: 'UNDO',

                        onPressed: () {
                          dismiss = Future.value(false);
                          setState(() {
                            articles.insert(index, article);
                          });
                        },
                      ),
                    )
                  );
                  return dismiss;
                }
              },
              background: Container(
                color: Colors.red,
                child: const Icon(Icons.delete),
                padding: EdgeInsets.only(left: 15),
                alignment: Alignment.centerLeft,
              ),
              secondaryBackground: Container(
                color: Colors.green,
                child: const Icon(Icons.shopping_cart),
                padding: EdgeInsets.only(right: 15),
                alignment: Alignment.centerRight,
              ),
              key: Key(articles[index].name),
              child: ListTile(
                title: Text(articles[index].name),
              ),
            ),
          );
        },
      ),
    );
  }
}