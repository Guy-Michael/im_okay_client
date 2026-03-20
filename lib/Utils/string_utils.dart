String interpolateString(String string, List<Object> params) {
  StringBuffer buffer = StringBuffer();
  String result = string;

  for (int i = 0; i < params.length; i++) {
    String placeholder = "{$i}";
    result = result.replaceAll(placeholder, params[i].toString());
  }

  buffer.write(result);
  return buffer.toString();
}
