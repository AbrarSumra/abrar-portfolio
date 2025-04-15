import 'dart:html' as html;

void downloadWeb() {
  final anchor = html.AnchorElement(href: 'assets/assets/resume.pdf')
    ..setAttribute('download', 'Abrar_Khira_Resume.pdf')
    ..click();

  print("Download initiated.");
}
