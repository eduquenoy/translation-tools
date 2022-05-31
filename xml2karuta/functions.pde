//Remplace les guillemets échappés (\' ou \") par un guillemet seul
String replaceEscapeQuote(String source){
String result;
  String string2find;
  //Guillemet simple
  string2find =  str(char(92))+str(char(92)) + str(char(39));
  result = source.replaceAll(string2find,str(char(39)));  

  //Guillemet double
  string2find =  str(char(92))+str(char(92)) + str(char(34));
  result = result.replaceAll(string2find,str(char(34)));  
  //println(result);
  return(result);
}
// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    /*String tmp[];
    for(int i=0;i< names.length);i++){
      tmp = split(names[i],'.');
    }*/
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}
String[] splitAtFirst(String source, String stringToFind){
  String[] line = new String[2];
  int pos;
  pos = source.indexOf(stringToFind);
  line[0] = source.substring(0, pos-1);
  line[1] = source.substring(pos+1,source.length());
  return(line);
}
String repeatChar(String source, int number){
  String result="";
  if(number>0){
    for(int i=0;i<=number;i++){
      result = result+source;
    }
  }
  return(result);
}
