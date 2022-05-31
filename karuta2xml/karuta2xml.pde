/*
Conversion d'un fichier de langue .js vers .xml au format Android https://support.crowdin.com/file-formats/android-xml/
Converting a .js to .xml file in Android format https://support.crowdin.com/file-formats/android-xml/
*/
//CONSTANTS

String LOCALE;//Choose the language to transform
String LOCALE_PREFIX;
String XML_MODEL; //XML model file
String DEFAULT_COMMENT; //Default comment
String REGEXPR; //To extract comments from comment lines
String PATH;//Path to locale source file

//Variables
String localeName;
String lineHead;
String localeSourceFileName;
String localeResultFileName;
String localeSource;

String[] line;
String[] source;
String[] tmp;
String index,text,comment;
XML xml, newChild;
String quotation="true";

JSONObject config; //Configuration file

/* Initializations */
void setup(){
   
   println("Processing...");  
   
   //Loading configuration file
   config = loadJSONObject("config.json");
   LOCALE = config.getString("LOCALE");
   LOCALE_PREFIX = config.getString("LOCALE_PREFIX");
   XML_MODEL = config.getString("XML_MODEL");
   DEFAULT_COMMENT = config.getString("DEFAULT_COMMENT");
   REGEXPR = config.getString("REGEXPR");
   PATH = config.getString("PATH");
   
   //Set variables
   localeName=LOCALE_PREFIX+LOCALE;
   lineHead="karutaStr['"+LOCALE+"']['";
   localeSourceFileName=localeName+".js";
   localeResultFileName=localeName+".xml";
   localeSource = PATH+localeSourceFileName;
   
  
   source = loadStrings(localeSource);//Loading the translation file from Karuta
   println("Loading ",localeSourceFileName);
   
    //Error on loading? 
   if(source != null){println("Open source file ok");} else{println("There is a problem with the source file!");}
   
   comment = DEFAULT_COMMENT;
   
   xml = loadXML(XML_MODEL); //Model loading

   noLoop();//La fonction Draw ne s'exécute qu'une fois
   surface.setVisible(false);//Pas de fenêtre Sketch
   
}
void draw(){
 
  if(source.length != 0){//Si le fichier est vide, on passe...
    println("File line number: ",source.length);
    
    for (int i = 0 ; i < source.length; i++) {//Pour chaque ligne du fichier à partir de la première ligne
      if (source[i].length() != 0) {//Si la ligne est vide, on passe
        if (source[i].charAt(0)!='/'){//Si la ligne est un commentaire, on traite
        
          if(source[i].indexOf("new Array()") <0){ //Création du tableau ? on passe...
         
             //Split the ligne
             line = splitAtFirst(source[i],"=");//on sépare en 2 au signe égal
         
             //Processing keys
             line[0] = trim(line[0]);//Nettoyage
             index = trim(line[0].substring(lineHead.length(),line[0].length()-2));//Extract key
 
             //Processing string
             line[1] = trim(line[1]);//Cleaning
             
             char quote = line[1].charAt(0);
             //println("Premier caractère : ",temp, " Taille : ", temp.length());
             if(quote == 34 || quote == 39){
               //text=trim(line[1].substring(1,line[1].length()-2)); //Texte entre guillemets simples ou doubles
               text=line[1].substring(1,line[1].length()-2); //Texte entre guillemets simples ou doubles
               quotation="true";
             }else{
               //text=trim(line[1].substring(0,line[1].length()-1)); //Texte sans guillemets
               text=line[1].substring(0,line[1].length()-1); //Texte sans guillemets
               quotation="false";
             }

             //XML update
             newChild = xml.addChild("string"); //Add an item
             newChild.setContent(text);
             newChild.setString("name",index);
             newChild.setString("comment",comment);
             newChild.setString("quotation",quotation);
        }
      }
      else{
        //Update comments
        tmp = match(source[i],REGEXPR);
        if(tmp!=null){
          comment = trim(tmp[0]); //update comment
        }
      }
     }
    }
    if(saveXML(xml, localeResultFileName)){println("Saving the XML went well");}else{println("Problem with saving XML file");} ;
    println("This is the end...");  
 }
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
  line[0] = source.substring(0, pos);
  line[1] = source.substring(pos+1,source.length());
  //println("Split : ",line[0], " / ", line[1]);
  return(line);
}
 
