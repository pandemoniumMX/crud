import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: true, home: MainApp()));
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtlastname = TextEditingController();
  TextEditingController txtmail = TextEditingController();

  TextEditingController txtnameM = TextEditingController();
  TextEditingController txtlastnameM = TextEditingController();
  TextEditingController txtmailM = TextEditingController();

  List? kind, table;
  String? dropkind;
  Future? ftable;
  bool _hidetable = false;

  final formAdd = GlobalKey<FormState>();
  final formUpdate = GlobalKey<FormState>();

  Future<String> loadKind() async {
    var response = await http.get(Uri.parse("/crud/dropKind.php"),
        headers: {"Accept": "application/json"});

    setState(() {
      kind = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> loadTable() async {
    var response = await http.get(Uri.parse("/crud/loadTable.php"),
        headers: {"Accept": "application/json"});

    setState(() {
      table = json.decode(response.body);
    });

    return "Success!";
  }

  Future<String> insertUser() async {
    var response = await http.get(
        Uri.parse(
            "/crud/insertUser.php?NAME=${txtname.text}&LAST=${txtlastname.text}&MAIL=${txtmail.text}&KIND=$dropkind"),
        headers: {"Accept": "application/json"});

    setState(() {
      // table = json.decode(response.body);
      ftable = loadTable();
    });

    return "Success!";
  }

  Future<String> updateUser(String id) async {
    var response = await http.get(
        Uri.parse(
            "/crud/updateUser.php?NAME=${txtnameM.text}&LAST=${txtlastnameM.text}&MAIL=${txtmailM.text}&KIND=$dropkind&ID=$id"),
        headers: {"Accept": "application/json"});

    setState(() {
      // table = json.decode(response.body);
      ftable = loadTable();
    });

    return "Success!";
  }

  Future<String> deleteUser(String id) async {
    var response = await http.get(Uri.parse("/crud/deleteUser.php?ID=$id"),
        headers: {"Accept": "application/json"});

    setState(() {
      // table = json.decode(response.body);
      ftable = loadTable();
    });

    return "Success!";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadKind();
    ftable = loadTable();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('CRUD TEST'),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (context, StateSetter setInnerState) {
                              return AlertDialog(
                                title: Text("Add user"),
                                content: Form(
                                  key: formAdd,
                                  child: Container(
                                    height: 300,
                                    width: 100,
                                    child: ListView(
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.verified_user),
                                          title: Container(
                                            width: 300,
                                            child: TextFormField(
                                              keyboardType: TextInputType.name,
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return 'No puede estar vacío';
                                                }

                                                return null;
                                              },
                                              controller: txtname,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  filled: true,
                                                  hintStyle: TextStyle(
                                                      color: Colors.black),
                                                  hintText: "Nombre(s)", //ENG
                                                  fillColor: Colors.white),
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.verified_user),
                                          title: Container(
                                            width: 300,
                                            child: TextFormField(
                                              keyboardType: TextInputType.name,
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return 'No puede estar vacío';
                                                }

                                                return null;
                                              },
                                              controller: txtlastname,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  filled: true,
                                                  hintStyle: TextStyle(
                                                      color: Colors.black),
                                                  hintText: "Apellidos", //ENG
                                                  fillColor: Colors.white),
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.mail),
                                          title: Container(
                                            width: 300,
                                            child: TextFormField(
                                              keyboardType: TextInputType.name,
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return 'No puede estar vacío';
                                                }

                                                return null;
                                              },
                                              controller: txtmail,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  filled: true,
                                                  hintStyle: TextStyle(
                                                      color: Colors.black),
                                                  hintText: "Email", //ENG
                                                  fillColor: Colors.white),
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.arrow_drop_down),
                                          title: Container(
                                            width: 180,
                                            child:
                                                DropdownButtonFormField<String>(
                                              decoration: InputDecoration(
                                                  filled: true,
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey[500]),
                                                  fillColor: Colors.white70),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'No puede estar vacío';
                                                } else if (int.parse(value) <=
                                                    0) {
                                                  return 'No puede ser 0';
                                                }

                                                return null;
                                              },
                                              value: dropkind,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              items: kind?.map((item) {
                                                    return DropdownMenuItem(
                                                      child: Text(item[
                                                          'KIND_NAME']), //ENG
                                                      value: item['idkindtbl']
                                                          .toString(),
                                                    );
                                                  }).toList() ??
                                                  [],
                                              hint: Text(
                                                "Categoría", //ENG
                                              ),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  dropkind = value;
                                                });
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  Center(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (formAdd.currentState!
                                              .validate()) {
                                            insertUser();
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: Text('Add')),
                                  )
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    child: Text('ADD')),
                _hidetable == false
                    ? ElevatedButton(
                        onPressed: () {
                          ftable = loadTable();
                          setState(() {
                            _hidetable = true;
                          });
                        },
                        child: Text('SHOW DATA'))
                    : ElevatedButton(
                        onPressed: () {
                          ftable = loadTable();
                          setState(() {
                            _hidetable = false;
                          });
                        },
                        child: Text('HIDE DATA'))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Visibility(
              visible: _hidetable,
              child: FutureBuilder(
                  future: ftable,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      default:
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('', style: TextStyle(fontSize: 25)));
                        } else if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return ListView.builder(
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              //padding: EdgeInsets.only(top: 2),
                              itemCount: table!.length,
                              itemBuilder: (
                                BuildContext context,
                                int index,
                              ) {
                                if (table! == null) {
                                  return Center(
                                      child: Text('',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25)));
                                } else {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(table![index]["USU_NAME"]),
                                      Text(table![index]["USU_LASTNAME"]),
                                      Text(table![index]["USU_MAIL"]),
                                      Text(table![index]["KIND_DESC"]),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.white)),
                                          onPressed: () {
                                            setState(() {
                                              txtnameM.text =
                                                  table![index]["USU_NAME"];
                                              txtlastnameM.text =
                                                  table![index]["USU_LASTNAME"];
                                              txtmailM.text =
                                                  table![index]["USU_MAIL"];
                                              dropkind =
                                                  table![index]["idkindtbl"];
                                            });

                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return StatefulBuilder(
                                                  builder: (context,
                                                      StateSetter
                                                          setInnerState) {
                                                    return AlertDialog(
                                                      title:
                                                          Text("Update user"),
                                                      content: Form(
                                                        key: formUpdate,
                                                        child: Container(
                                                          height: 300,
                                                          width: 100,
                                                          child: ListView(
                                                            children: [
                                                              ListTile(
                                                                leading: Icon(Icons
                                                                    .verified_user),
                                                                title:
                                                                    Container(
                                                                  width: 300,
                                                                  child:
                                                                      TextFormField(
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .name,
                                                                    validator:
                                                                        (val) {
                                                                      if (val!
                                                                          .isEmpty) {
                                                                        return 'No puede estar vacío';
                                                                      }

                                                                      return null;
                                                                    },
                                                                    controller:
                                                                        txtnameM,
                                                                    decoration: InputDecoration(
                                                                        border: OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20.0),
                                                                        ),
                                                                        filled: true,
                                                                        hintStyle: TextStyle(color: Colors.black),
                                                                        hintText: "Nombre(s)", //ENG
                                                                        fillColor: Colors.white),
                                                                  ),
                                                                ),
                                                              ),
                                                              ListTile(
                                                                leading: Icon(Icons
                                                                    .verified_user),
                                                                title:
                                                                    Container(
                                                                  width: 300,
                                                                  child:
                                                                      TextFormField(
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .name,
                                                                    validator:
                                                                        (val) {
                                                                      if (val!
                                                                          .isEmpty) {
                                                                        return 'No puede estar vacío';
                                                                      }

                                                                      return null;
                                                                    },
                                                                    controller:
                                                                        txtlastnameM,
                                                                    decoration: InputDecoration(
                                                                        border: OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20.0),
                                                                        ),
                                                                        filled: true,
                                                                        hintStyle: TextStyle(color: Colors.black),
                                                                        hintText: "Apellidos", //ENG
                                                                        fillColor: Colors.white),
                                                                  ),
                                                                ),
                                                              ),
                                                              ListTile(
                                                                leading: Icon(
                                                                    Icons.mail),
                                                                title:
                                                                    Container(
                                                                  width: 300,
                                                                  child:
                                                                      TextFormField(
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .name,
                                                                    validator:
                                                                        (val) {
                                                                      if (val!
                                                                          .isEmpty) {
                                                                        return 'No puede estar vacío';
                                                                      }

                                                                      return null;
                                                                    },
                                                                    controller:
                                                                        txtmailM,
                                                                    decoration: InputDecoration(
                                                                        border: OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20.0),
                                                                        ),
                                                                        filled: true,
                                                                        hintStyle: TextStyle(color: Colors.black),
                                                                        hintText: "Email", //ENG
                                                                        fillColor: Colors.white),
                                                                  ),
                                                                ),
                                                              ),
                                                              ListTile(
                                                                leading: Icon(Icons
                                                                    .arrow_drop_down),
                                                                title:
                                                                    Container(
                                                                  width: 180,
                                                                  child:
                                                                      DropdownButtonFormField<
                                                                          String>(
                                                                    decoration: InputDecoration(
                                                                        filled:
                                                                            true,
                                                                        hintStyle: TextStyle(
                                                                            color: Colors.grey[
                                                                                500]),
                                                                        fillColor:
                                                                            Colors.white70),
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                              null ||
                                                                          value
                                                                              .isEmpty) {
                                                                        return 'No puede estar vacío';
                                                                      } else if (int.parse(
                                                                              value) <=
                                                                          0) {
                                                                        return 'No puede ser 0';
                                                                      }

                                                                      return null;
                                                                    },
                                                                    value:
                                                                        dropkind,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        overflow:
                                                                            TextOverflow.ellipsis),
                                                                    items: kind?.map(
                                                                            (item) {
                                                                          return DropdownMenuItem(
                                                                            child:
                                                                                Text(item['KIND_NAME']), //ENG
                                                                            value:
                                                                                item['idkindtbl'].toString(),
                                                                          );
                                                                        }).toList() ??
                                                                        [],
                                                                    hint: Text(
                                                                      "Categoría", //ENG
                                                                    ),
                                                                    onChanged:
                                                                        (String?
                                                                            value) {
                                                                      setState(
                                                                          () {
                                                                        dropkind =
                                                                            value;
                                                                      });
                                                                    },
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      actions: [
                                                        Center(
                                                          child: ElevatedButton(
                                                              onPressed: () {
                                                                if (formUpdate
                                                                    .currentState!
                                                                    .validate()) {
                                                                  updateUser(table![
                                                                          index]
                                                                      [
                                                                      "idusertbl"]);
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              },
                                                              child:
                                                                  Text('Add')),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                          )),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.white)),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return StatefulBuilder(
                                                  builder: (context,
                                                      StateSetter
                                                          setInnerState) {
                                                    return AlertDialog(
                                                      title: Text("Alert"),
                                                      content:
                                                          Text('Delete user?'),
                                                      actions: [
                                                        Center(
                                                          child: ElevatedButton(
                                                              onPressed: () {
                                                                deleteUser(table![
                                                                        index][
                                                                    "idusertbl"]);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  Text('YES')),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ))
                                    ],
                                  );
                                }
                              });
                        }
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
