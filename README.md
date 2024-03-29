# translation-tools
_Translation tools for Karuta_

## ![](https://icons.iconarchive.com/icons/custom-icon-design/flat-europe-flag/48/France-icon.png)Outils pour la transformation de fichiers compatibles avec Crowdin
### Présentation
Il s'agit d'outils permettant de transformer des fichiers de langues de l'application [Karuta](https://github.com/karutaproject) vers un format reconnu par la plate-forme d'aide à la traduction [Crowdin](https://crowdin.com/project/karuta-eporfolio).
- l'environnement de développement utilisé est [Processing](https://processing.org/)
- pour utiliser un outil, il faut au préalable installer la version de [Processing](https://processing.org/) correspondant à votre machine puis télécharger le contenu du dépôt Github. Initialisez ensuite le fichier `config.json` de chaque outil puis ouvrez le fichier `.pde` pour lancer un outil.
- liste des outils :
  - `karuta2xml` : pour la transformation d'un fichier de langue javascript vers un fichier au format XML compatible avec Crowdin
  - `xml2karuta` : pour la transformation d'un ou pluseurs fichiers de langue XML, issus de la plate-forme Crowdin, vers les fichiers javascript au format de Karuta
- format des fichiers `.xml` : [Android](https://support.crowdin.com/file-formats/android-xml/)
- format des fichiers `.js` : voir le [Github de Karuta](https://github.com/karutaproject/karuta-frontend/tree/master/WebContent/karuta/js/languages)

### Outil `karuta2xml`
- commencez par dupliquer le fichier `config-model.json` en `config.json`
- ajustez éventuellement les noms de dossiers contenant le fichier source `.js`et le fichier source `.xml` (généré par `karuta2xml`) : lignes `SOURCE_JS` et `SOURCE_XML`
- modifiez la ligne  `"PATH" : "/path/to/your/file/to/transform"` avec le chemin vers le dossier principal qui contiendra les 4 dossiers fichier `.js` initial (n'indiquez pas le nom du fichier ni le dossier contenant le fichier .js ou le fichier .xml). Par exemple : `/users/duke/myproject/locales/`
- vérifiez que les autres lignes du fichier `config.json` vous conviennent
- __IMPORTANT__ : le chemin indiqué par `PATH` sera synchronisé sur Github et configuré dans Crowdin comme source (branche _main_) et destination (branche _i10n_main_) des traductions


### Outil `xml2karuta`
- commencez par dupliquer le fichier `config-model.json` en `config.json`
- modifiez la ligne  `"PATH" : "/path/to/your/file/to/transform"` avec le chemin vers les dossiers qui contiennent les fichiers `.xml` générés par Crowdin (n'indiquez pas de nom de fichier) et les fichiers `.js` qui seront générés par `xml2karuta`. Par exemple `/users/duke/myproject/crowdin/`
- choisissez les langues à utiliser en modifiant les lignes de l'élément `LOCALES`

## ![](https://icons.iconarchive.com/icons/custom-icon-design/flat-europe-flag/48/United-Kingdom-icon.png)Tools for transforming files compatible with Crowdin

### Introduction
These are tools for transforming language files from the [Karuta](https://github.com/karutaproject)  application into a format recognized by the translation support platform [Crowdin](https://crowdin.com/project/karuta-eportfolio).
- development tool is [Processing](https://processing.org/)
- list of tools:
  - `karuta2xml`: transformation of a javascript language file into a file in XML format compatible with Crowdin
  - `xml2karuta`: transformation of one or more XML language files, from the Crowdin platform, into javascript files in Karuta format
- `.xml` file format: [Android](https://support.crowdin.com/file-formats/android-xml/)
- `.js` file format: see the [Karuta Github](https://github.com/karutaproject/karuta-frontend/tree/master/WebContent/karuta/js/languages)

### `karuta2xml` tool
- start by duplicating the `config-model.json` file to `config.json`
- modify the `"PATH" line: "/path/to/your/file/to/transform"` with the path to the initial `.js` file (do not indicate the file name). For example: `/users/duke/myproject/locales/`
- check that the other lines of the `config.json` file are correct for you


### `xml2karuta` tool
- start by duplicating the `config-model.json` file to `config.json`
- modify the `"PATH" line: "/path/to/your/file/to/transform"` with the path to the `.xml` files generated by Crowdin (do not specify a file name). For example `/users/duke/myproject/crowdin/xml/`
- choose the languages ​​to use by modifying the lines of the `LOCALES` element