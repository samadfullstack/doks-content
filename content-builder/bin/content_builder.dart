import 'content_writer2.dart';
import 'utils/content_writer.dart';

void main(List<String> args) async {
  // writeContent();
  ContentWriter.write().then((value) => print("Successfully written content............."));
}
