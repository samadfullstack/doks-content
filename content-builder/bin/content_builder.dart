import 'utils/content_writer.dart';

void main(List<String> args) async {
  ContentWriter.write().then((value) => print("Successfully written content"));
}
