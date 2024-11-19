import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

List<pw.Widget> parseHtmlToPdfWidgets(dom.Element? element) {
  if (element == null) return [];

  List<pw.Widget> widgets = [];

  for (var node in element.nodes) {
    if (node is dom.Text) {
      // Handle plain text
      widgets.add(
          pw.Text(node.text?.trim() ?? "", style: pw.TextStyle(fontSize: 12)));
    } else if (node is dom.Element) {
      switch (node.localName) {
        case 'b':
          widgets.add(pw.Text(node.text ?? "",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)));
          break;
        case 'i':
          widgets.add(pw.Text(node.text ?? "",
              style: pw.TextStyle(fontStyle: pw.FontStyle.italic)));
          break;
        case 'h1':
          widgets.add(pw.Text(node.text ?? "",
              style:
                  pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)));
          break;
        case 'h2':
          widgets.add(pw.Text(node.text ?? "",
              style:
                  pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)));
          break;
        case 'ul':
          widgets.add(pw.Bullet(
              text: node.text ?? "", style: pw.TextStyle(fontSize: 12)));
          break;
        case 'ol':
          int index = 1;
          for (var child in node.children) {
            widgets.add(pw.Row(
              children: [
                pw.Text("$index. ", style: pw.TextStyle(fontSize: 12)),
                pw.Text(child.text ?? "", style: pw.TextStyle(fontSize: 12)),
              ],
            ));
            index++;
          }
          break;
        case 'p':
          widgets.add(pw.Text(node.text ?? "",
              style: pw.TextStyle(fontSize: 12, height: 1.5)));
          break;
        default:
          widgets.addAll(parseHtmlToPdfWidgets(node));
      }
    }
  }

  return widgets;
}
