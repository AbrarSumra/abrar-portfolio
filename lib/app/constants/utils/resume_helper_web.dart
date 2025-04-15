import 'dart:html' as html;

void downloadWeb() {
  final anchor = html.AnchorElement(href: 'assets/resume/resume.pdf')
    ..setAttribute('download', 'Abrar_Khira_Resume.pdf')
    ..target = 'blank'
    ..click();

  print("Download initiated.");
}
