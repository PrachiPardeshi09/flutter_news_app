import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/news_description_page/news_description_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class NewsDescriptionView extends GetView<NewsDescriptionController> {
  downloadPdf() async{
    Directory? appDocDir = await getExternalStorageDirectory();
    String? appDocPath = appDocDir?.path;
    List<String>? splittedPath = appDocPath?.split('/');
    int i = 0;
    for(i=0;i<splittedPath!.length;i++){
      if(splittedPath[i]=='0'){
        break;
      }
    }
    splittedPath=splittedPath.sublist(0,i+1);
    splittedPath.add('Download');
    String combinedPath = splittedPath.join('/');
    print(combinedPath+' is combined path');
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Expanded(child: pw.Column(children: [
              pw.Text(('Tittle: ${controller.singleEvent.value!.title}')),
              pw.Text(controller.singleEvent.value!.author),
              pw.Text(controller.singleEvent.value!.description),

            ]))
          );
        }));

    final file = File("${combinedPath}/${controller.singleEvent.value!.title}example.pdf");
    await file.writeAsBytes(await pdf.save());
    if (await file.exists()) {
      print('Saved file size: (${file.path}) : ${file.lengthSync()}');
    }
    print('pdf clicked');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text('News Description')) ,
        body: Obx(()=>
     Container(
      color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(controller.singleEvent.value!.urlToImage),
                  SizedBox(
                    height: 8,
                  ),
                  Text(('Tittle: ${controller.singleEvent.value!.title}'), style: TextStyle(color: Colors.black)),
                  Divider(),
                  SizedBox(
                    height: 8,
                  ),
                  Text(('Author: ${controller.singleEvent.value!.author}'), style: TextStyle(color: Colors.black)),
                  Divider(),
                  SizedBox(
                    height: 8,
                  ),
                  Text(('Description: ${controller.singleEvent.value!.description}'), style: TextStyle(color: Colors.black)),
                  Divider(),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      downloadPdf();

                    },
                    child: Text('Dowmload as Pdf'),
                  )
                ],
              ),
            ),
    ),
        ));
  }
}
