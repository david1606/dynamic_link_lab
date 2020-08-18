import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_link_lab/src/services/dynamicLinks.dart';
import 'package:dynamic_link_lab/src/services/dynamic_link_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class HomeAct extends StatefulWidget {
  HomeAct(String data);

  @override
  _HomeActState createState() => _HomeActState();
}

DynamicLinks dynamicLinks = new DynamicLinks();

class _HomeActState extends State<HomeAct> {
  @override
  Widget build(BuildContext context) {
    final linkModel = Provider.of<DynamicLinkProvider>(context);
    return linkModel.dynamicLink != '' && linkModel.dynamicLink != null
        ? Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('posts')
                        .document('zWmkymISHkE0BmE7AZhK')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Container();
                      var document = snapshot.data;
                      final _processData = {
                        'postID': document.documentID,
                        'business_logo': document['b_logo'],
                        'business_name': document['b_name'],
                        'post_business_uid': document['p_business_uid'],
                        'post_image': document['p_image'],
                        'post_text': document['p_text'],
                        'post_time': document['p_time'],
                        'post_time_format': document['p_time'].toString(),
                        'post_title': document['p_title'],
                        'post_user_comment': document['post_user_comment'],
                        'post_comment_length':
                            document['p_user_comment'].length,
                        'post_user_likes': document['p_user_likes'],
                        'user_likes_length': document['p_user_likes'].length,
                        'user_like': true,
                        'post_users_mark': document['p_users_mark'],
                        'users_mark_length': document['p_users_mark'].length,
                        'user_mark': true,
                        'post_visibility': document['p_visibility'],
                      };
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Colors.black12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 45,
                              margin: EdgeInsets.only(
                                left: 10.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              image: DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                        _processData[
                                                            'business_logo']),
                                                fit: BoxFit.cover,
                                              )),
                                          height: 30.0,
                                          width: 30.0,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          _processData['business_name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {},
                                    padding: EdgeInsets.all(0.0),
                                    iconSize: 20.0,
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              child: CachedNetworkImage(
                                imageUrl: _processData['post_image'],
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fitWidth,
                                fadeInDuration: Duration(milliseconds: 500),
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/img/logo.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              onTap: () {},
                            ),
                            Row(
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(
                                      Icons.thumb_up,
                                      color:
                                          _processData['user_likes_length'] != 0
                                              ? _processData['user_like'] ==
                                                      true
                                                  ? Colors.blue
                                                  : Colors.black
                                              : Colors.black,
                                    ),
                                    onPressed: () {}),
                                IconButton(
                                  icon: Icon(Icons.insert_comment,
                                      color: Colors.black),
                                  onPressed: () {},
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.flip,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {}),
                                IconButton(
                                    icon: Icon(
                                      Icons.share,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      share(context, document.documentID);
                                    }),
                                Expanded(child: Container()),
                                IconButton(
                                    icon: Icon(
                                      _processData['users_mark_length'] != 0
                                          ? _processData['user_mark'] == true
                                              ? Icons.bookmark
                                              : Icons.bookmark_border
                                          : Icons.bookmark_border,
                                      color:
                                          _processData['users_mark_length'] != 0
                                              ? _processData['user_mark'] ==
                                                      true
                                                  ? Colors.blue
                                                  : Colors.black
                                              : Colors.black,
                                    ),
                                    onPressed: () {}),
                              ],
                            ),
                            _processData['user_likes_length'] != 0
                                ? Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            _processData['user_likes_length'] !=
                                                    0
                                                ? 10.0
                                                : 0.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          '${_processData['user_likes_length']} Me gusta',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ))
                                : Container(),
                            //SizedBox(height: 10.0),
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                child: RichText(
                                  text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: [
                                        TextSpan(
                                            text:
                                                '${_processData['business_name']}: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: _processData['post_text'],
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ]),
                                )),
                            SizedBox(
                                height: _processData['post_comment_length'] != 0
                                    ? 5.0
                                    : 0.0),
                            GestureDetector(
                              onTap: () {},
                              child: _processData['post_comment_length'] != 0
                                  ? Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Text(
                                        _processData['post_comment_length'] == 1
                                            ? 'Ver un ${_processData['post_comment_length']} comentario'
                                            : 'Ver los ${_processData['post_comment_length']} comentarios',
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                  : Container(),
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  // Text(DateFormat("hh:mm:ss").format(DateTime.fromMicrosecondsSinceEpoch(document['post_time'])),
                                  Text(_processData['post_time_format'],
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 12.0))
                                ],
                              ),
                            ),
                            SizedBox(height: 20.0)
                          ],
                        ),
                      );
                    }),
              ),
            ),
          )
        : Scaffold(
            body: Center(
              child: Text('No hay informacion'),
            ),
          );
  }

  void share(BuildContext context, documentID) async {
    String str = await dynamicLinks.createLinkWithDocID(documentID);
    Share.share(str, subject: 'Hello');
  }
}
