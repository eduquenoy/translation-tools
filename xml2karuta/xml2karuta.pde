/*
Transformation des fichiers .xml contenant les traductions vers fichier .js au format de Karuta
*/
//CONSTANTES
String PATH; 
String LOCALE_PREFIX ;
String EXT_IN;
String EXT_OUT; 
String COMMENT_PATTERN;
JSONArray LOCALES;

//Construction du .js
String HEADER1  = "karutaStr['";
String HEADER2  = "'] = new Array();";
String BEGIN    = "";
String BEETWEEN = "']['";
String END      = "']=";

//Variables
String[] localList;
String fileName; //le nom du fichier à charger
String localFileName;// Le nom du fichier de sortie
int dicoSize;
StringList lines;
XML fileXML;
String comment,commentOld,quotation;


JSONObject config; //Configuration file

void setup(){
  
   println("Début du traitement !");  

   //Loading configuration file
   config = loadJSONObject("config.json");  
   LOCALES =  config.getJSONArray("LOCALES");
   localList = new String[LOCALES.size()];
   for(int i =0;i<localList.length;i++){
     localList[i] = LOCALES.getString(i);
   }
   PATH = config.getString("PATH");
   COMMENT_PATTERN = config.getString("COMMENT_PATTERN");
   EXT_IN = config.getString("EXT_IN");
   EXT_OUT = config.getString("EXT_OUT");
   LOCALE_PREFIX = config.getString("LOCALE_PREFIX");
   
   noLoop();//La fonction Draw ne s'exécute qu'une fois
   surface.setVisible(false);//Pas de fenêtre Sketch
   
}
void draw(){
  
    //Pour chaque fichier .xml de la liste, on applique le même traitement
    for(int i=0;i<localList.length;i++){
      
      //Construction du nom de fichier complet
      fileName = PATH + LOCALE_PREFIX + localList[i] + EXT_IN ;
             //Chargement du fichier .xml
      fileXML = loadXML(fileName);
      
      //Nombre de clefs
      XML[] children = fileXML.getChildren("string");  
      dicoSize = children.length;

      println("langue : ", localList[i], " taille : ", dicoSize, " clefs");  //Vérification
      
      //Dimensionnement du tableau de sortie
      lines  = new StringList(); //Création du tableau de sortie
      
      //Ligne d'entête du tableau de sortie
      lines.append(HEADER1 + localList[i] + HEADER2);
      
      //Extraction des traductions
      for(int j=0; j< dicoSize; j++){
        
          //Traitement des commentaires
          comment=children[j].getString("comment");
          if(comment.equals(commentOld) == false){
            commentOld = comment;
            int size= COMMENT_PATTERN.length()-6-comment.length();
            lines.append("");
            lines.append(COMMENT_PATTERN);
            lines.append("//"+repeatChar("=",floor(size/2))+" "+comment+" "+repeatChar("=",size-floor(size/2)));
            lines.append(COMMENT_PATTERN);
            lines.append("");
          }
          //Traitement des guillemets
          quotation=children[j].getString("quotation");
          if(quotation.equals("true")){//Avec guillemets
            lines.append(HEADER1 + localList[i] + BEETWEEN + children[j].getString("name") + END + '"' + replaceEscapeQuote(children[j].getContent()) + '"' + char(59));
          }
          else{ //Sans guillemets
            lines.append(HEADER1 + localList[i] + BEETWEEN + children[j].getString("name") + END + replaceEscapeQuote(children[j].getContent()) + char(59));            
          }
      }
      //Création du fichier .js
      localFileName = LOCALE_PREFIX + localList[i] + EXT_OUT;
      saveStrings(localFileName,lines.array());
    }
    
    //Fin du traitement
    println("Fin du traitement !");  
}
