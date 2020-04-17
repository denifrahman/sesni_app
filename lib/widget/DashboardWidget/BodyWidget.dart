import 'dart:convert';
import 'package:loading_animations/loading_animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:sesnic_app/Utils/LocalBindings.dart';
import 'package:sesnic_app/models/penjamin.dart';
import 'package:sesnic_app/provider/booking.dart';
import 'package:sesnic_app/screen/Cabang/CabangScreen.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({
    Key key,
  }) : super(key: key);

  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  var dataHistory = new List<Penjamin>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getKlinik();
  }

  @override
  Widget build(BuildContext context) {
    print(dataHistory);
    return Container(
      height: MediaQuery.of(context).size.height / 2 + 70,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
            child: Container(
              height: 80,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.all(Radius.circular(3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          child: new Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.only(bottom: 3),
                              decoration: new BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                gradient: new LinearGradient(
                                    colors: [
                                      Colors.blue.withOpacity(0.1),
                                      Colors.white
                                    ],
                                    begin: const FractionalOffset(7.0, 10.1),
                                    end: const FractionalOffset(0.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              child: new Center(
                                child: Icon(
                                  FontAwesomeIcons.addressCard,
                                  size: 18,
                                  color: Colors.blue,
                                ),
                              )),
                        ),
                        Text(
                          'ID Pasien',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          child: new Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.only(bottom: 3),
                              decoration: new BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                gradient: new LinearGradient(
                                    colors: [
                                      Colors.orange.withOpacity(0.1),
                                      Colors.white
                                    ],
                                    begin: const FractionalOffset(7.0, 10.1),
                                    end: const FractionalOffset(0.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              child: new Center(
                                child: Icon(
                                  FontAwesomeIcons.shieldAlt,
                                  size: 18,
                                  color: Colors.orange,
                                ),
                              )),
                        ),
                        Text(
                          'Asuransi',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          child: new Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.only(bottom: 3),
                              decoration: new BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                gradient: new LinearGradient(
                                    colors: [
                                      Colors.green.withOpacity(0.1),
                                      Colors.white
                                    ],
                                    begin: const FractionalOffset(7.0, 10.1),
                                    end: const FractionalOffset(0.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              child: new Center(
                                child: Icon(
                                  FontAwesomeIcons.arrowAltCircleRight,
                                  size: 18,
                                  color: Colors.green,
                                ),
                              )),
                        ),
                        Text(
                          'Aktivitas',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          child: new Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.only(bottom: 3),
                              decoration: new BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                gradient: new LinearGradient(
                                    colors: [
                                      Colors.pinkAccent.withOpacity(0.1),
                                      Colors.white
                                    ],
                                    begin: const FractionalOffset(7.0, 10.1),
                                    end: const FractionalOffset(0.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              child: new Center(
                                child: Icon(
                                  FontAwesomeIcons.solidHeart,
                                  size: 18,
                                  color: Colors.pinkAccent,
                                ),
                              )),
                        ),
                        Text(
                          'Favorit',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 4),
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(0))),
                child: InkWell(
                  onTap: () => _search(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Cari Klinik',
                        style: TextStyle(fontSize: 11),
                      ),
                      Icon(
                        Icons.search,
                        size: 20,
                      )
                    ],
                  ),
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 40,
            height: MediaQuery.of(context).size.height / 2 - 60,
            padding: EdgeInsets.only(left: 5, right: 5),
            decoration: new BoxDecoration(
              color: Colors.white,
              //new Color.fromRGBO(255, 0, 0, 0.0),
              border: Border(
                left: BorderSide(width: 0.3, color: Colors.grey[300]),
                top: BorderSide(width: 0.3, color: Colors.grey[300]),
                right: BorderSide(width: 0.3, color: Colors.grey[300]),
              ),
            ),
            child: dataHistory == []
                ? Center(
                  child: LoadingDoubleFlipping.square(
                      size: 30, backgroundColor: Colors.red),
                )
                : ListView.builder(
                    padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                    itemCount: dataHistory.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Container(
                            child: ListTile(
                              onTap: () => _cabang(context),
                              title: Text(
                                dataHistory[index].penjaminNama == null
                                    ? 'Kosong'
                                    : dataHistory[index].penjaminNama,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[700]),
                              ),
                              subtitle: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 12,
                                  ),
                                  Text(
                                    ' 4,6',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Container(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.credit_card,
                                    color: Colors.blue,
                                    size: 12,
                                  ),
                                  Text(
                                    ' BPJS',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.green),
                                  ),
                                  Container(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 12,
                                  ),
                                  Text(
                                    ' Surabaya',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey[700]),
                                  )
                                ],
                              ),
                              trailing: SizedBox(
                                height: 30.0,
                                width: 25.0,
                                child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.heart,
                                    size: 18,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              leading: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: new BoxDecoration(
                                      color: Colors.grey[200].withOpacity(0.8),
                                      //new Color.fromRGBO(255, 0, 0, 0.0),
                                      borderRadius: new BorderRadius.all(
                                          Radius.circular(40.0))),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Icon(Icons.business))),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Divider(),
                          )
                        ],
                      );
                    }),
          ),
        ],
      ),
    );
  }

  _cabang(context) {
    Navigator.of(context).push(PageRouteTransition(
        animationType: AnimationType.slide_up,
        builder: (context) => CabangScreen()));
  }

  _search(context) async {
//    LocalStorage.sharedInstance.deleteValue('historySearch');
    String historySearch =
        await LocalStorage.sharedInstance.readValue('historySearch');
    print(' set $historySearch');
    if (historySearch == null) {
      historySearch = '[]';
    }
    Api.getAllPenjamin().then((response) {
      Iterable list = json.decode(response.body)['data'];
      setState(() {
        dataHistory = list.map((model) => Penjamin.fromJson(model)).toList();
      });
      showSearch(
          context: context,
          delegate: CabangSearchDelegate(
              list.map((model) => Penjamin.fromJson(model)).toList(),
              json.decode(historySearch)));
    });
  }

  _getKlinik() {
    Api.getAllPenjamin().then((response) {
      Iterable list = json.decode(response.body)['data'];
      setState(() {
        dataHistory = list.map((model) => Penjamin.fromJson(model)).toList();
      });
    });
  }
}

typedef OnSearchChanged = Future<List<String>> Function(String);

class CabangSearchDelegate extends SearchDelegate<String> {
  final List<Penjamin> result;
  final List<dynamic> historySearch;
  final data = ["Klinik Pratama", "Klinik Mawar", "Klinik Sentosa", "Kita"];
  var tempHistory = [];
  CabangSearchDelegate(this.result, this.historySearch)
      : super(
          searchFieldLabel: "Cari klinik",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
//    if(historySearch.length == 0 && tempHistory.length == 0){
//      tempHistory = ['"$query"'];
//      print('kosong all');
//    }else{
//      print('kosong');
//      historySearch.add('"$query"');
////      tempHistory.add(json.encode(historySearch));
//    LocalStorage.sharedInstance.writeValue(key: 'historySearch', value: '$tempHistory');
//    }
//    var a = json.encode(historySearch).replaceAll('[', '');
//    print('akhir $a');
//    print("'$tempHistory'");
    final suggestionList = query.isEmpty
        ? result.take(3).toList()
        : result.where((a) => a.penjaminId.contains(query)).toList();
    return ListView.builder(
        padding: EdgeInsets.only(left: 5, right: 5, top: 10),
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Container(
                child: ListTile(
                  onTap: () => _openCabang(context),
                  title: Text(
                    suggestionList[index].penjaminNama == null
                        ? "Kosong"
                        : suggestionList[index].penjaminNama,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700]),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 12,
                      ),
                      Text(
                        ' 4,6',
                        style: TextStyle(fontSize: 10),
                      ),
                      Container(
                        width: 8,
                      ),
                      Icon(
                        Icons.credit_card,
                        color: Colors.blue,
                        size: 12,
                      ),
                      Text(
                        ' BPJS',
                        style: TextStyle(fontSize: 10, color: Colors.green),
                      ),
                      Container(
                        width: 8,
                      ),
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 12,
                      ),
                      Text(
                        ' Surabaya',
                        style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                      )
                    ],
                  ),
                  trailing: SizedBox(
                    height: 30.0,
                    width: 25.0,
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.heart,
                        size: 18,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  leading: Container(
                      width: 50,
                      height: 50,
                      decoration: new BoxDecoration(
                          color: Colors.grey[200].withOpacity(0.8),
                          //new Color.fromRGBO(255, 0, 0, 0.0),
                          borderRadius:
                              new BorderRadius.all(Radius.circular(40.0))),
                      child: Align(
                          alignment: Alignment.center,
                          child: Icon(Icons.business))),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Divider(),
              )
            ],
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    print(historySearch.length);
    final suggestionList = query.isEmpty
        ? result.take(3).toList()
        : result.where((a) => a.penjaminId.contains(query)).toList();
    return query.isEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Riwayat Pencarian',
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                height: 55,
                child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    scrollDirection: Axis.horizontal,
                    itemCount: suggestionList.length,
                    itemBuilder: (BuildContext, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 5),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: InkWell(
                            onTap: () {
                              query = '3';
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Center(child: Text('Klinik Kandungan')),
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          )
        : ListView.builder(
            padding: EdgeInsets.only(left: 5, right: 5, top: 10),
            itemCount: suggestionList.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  Container(
                    child: ListTile(
                      onTap: () => _openCabang(context),
                      title: Text(
                        suggestionList[index].penjaminNama == null
                            ? "Kosong"
                            : suggestionList[index].penjaminNama,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700]),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 12,
                          ),
                          Text(
                            ' 4,6',
                            style: TextStyle(fontSize: 10),
                          ),
                          Container(
                            width: 8,
                          ),
                          Icon(
                            Icons.credit_card,
                            color: Colors.blue,
                            size: 12,
                          ),
                          Text(
                            ' BPJS',
                            style: TextStyle(fontSize: 10, color: Colors.green),
                          ),
                          Container(
                            width: 8,
                          ),
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 12,
                          ),
                          Text(
                            ' Surabaya',
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey[700]),
                          )
                        ],
                      ),
                      trailing: SizedBox(
                        height: 30.0,
                        width: 25.0,
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.heart,
                            size: 18,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      leading: Container(
                          width: 50,
                          height: 50,
                          decoration: new BoxDecoration(
                              color: Colors.grey[200].withOpacity(0.8),
                              //new Color.fromRGBO(255, 0, 0, 0.0),
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(40.0))),
                          child: Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.business))),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Divider(),
                  )
                ],
              );
            });
  }

  _openCabang(context) {
    Navigator.of(context).push(PageRouteTransition(
        animationType: AnimationType.slide_up,
        builder: (context) => CabangScreen()));
  }
}
