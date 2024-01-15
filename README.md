# jeu_geo

Ce projet Flutter réalisé dans le cadre du projet de fin d'UE est une application de jeu de géographie.

## Table des matières

- [Présentation de l'Application](#présentation-de-lapplication)
- [API utilisée](#api)
- [Jeu Capitales](#jeu-capitales)
- [Jeu Drapeaux](#jeu-drapeaux)
- [Structure du Projet](#structure-du-projet)
   - [lib/](#lib)
   - [-- blocs](#blocs)
   - [-- models](#models)
   - [-- repository](#repository)
   - [-- ui.screens](#ui.screens)
   - [-- widgets](#widgets)
   - [main](#main)
   - [router](#router)
- [Difficultés Rencontrées](#difficultés-rencontrées)
- [Captures d'écran](#captures-décran)
- [Fonctionnalités](#fonctionnalités)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Dépendances](#dépendances)
- [Contributions](#contributions)
- [Licence](#licence)

## Présentation de l'Application
L'application comporte deux jeux axés sur la géographie pour s'amuser et se perfectionner dans ce domaine. Choisissez entre trouver les capitales des pays indiqués ou trouver les pays correspondant aux drapeaux. Avec une interfae utilisateur 
## API utilisée

Pour la réalisation de ce projet nous avons utiliser l'API restcountries disponible via ce [lien]([https://restcountries.com/v3.1/all?fields=name,capital,capitalInfo](https://restcountries.com)). Après l'avoir prise en main grâce à quelques requêtes nous avons modifié ces requêtes pour orienter nos demandes et obtenir seulement les informations nécessaires car cette API nous renvoyait un nombre impressionant d'informations. Les informations qui nous importaient étaient le nom des pays, leur capitale ainsi que leur drapeau. Le nom et la capitale nous sont utiles pour le jeu Capitales et le nom et le drapeau pour le jeu Drapeaux.

## Jeu Capitales
Dans ce jeu le but est de trouver la capitale des pays afficher sur une carte. Chaque pays est marquée d'un icone cliquable qui, une fois cliqué, ouvre une boite de dialogue permettant d'entrer notre réponse et un bouton 'Submit' pour la valider. 
Le joueur peut sélectionner son pseudo et le zone géographique sur laquelle il souhaite jouer(Europe, Asie, Afrique, Amérique, Monde, Océanie).
Ensuite, si la réponse est correcte un message de réussite vert apparaît pendant quelques secondes puis la boite disparaît afin de continuer le jeu. En revanche, si la réponse soumise est fausse un message d'erreur rouge apparaît pendant quelques secondes et la boite de dialogue reste ouverte, pour la fermer il faut appuyer sur le bouton 'Cancel'. Il y a la possibilité de mettre le jeu en pause en cliquant sur l'icone menu dans l'appBar; cette action ouvrant une sidebar qui couvre partiellement la zone de jeu avec 4 zones cliquables correspondant aux 4 actions possibles à savoir : 
   - 'Resume' pour continuer de jouer et relancer le chronomètre
   - 'Restart' pour recommencer le jeu à zéro, redémmarer le chrnomètre et réinitialiser le score à 0
   - 'Quit' pour quitter la page de jeu et revenir à la page de sélection de la zone géographique.
   - 'Done' pour finir la partir, enregistrer le temps et le score actuel
Au bout de 15 minutes de jeu une boite d'alerte apparait pour indiquer au joueur que le temps est écoulé, 3 choix s'offrent alors à lui : il peut soit rejouer une partie, soit quitter le jeu et revenir à la page de sélection de la zone géographique ou encore accéder à la page de tableaux des scores.
Pour plus de compréhension voir [Captures d'écran](#capture-decran-jeu-capitals).


## Jeu Drapeaux
Ayant assez rapidement clotûré l'implémentation du jeu Capitals nous avons pensé ajouter un mode de jeu avec les drapeaux. Nous avons donc développé ce nouveau jeu de la récupération des informations au niveau de l'API jusqu'à un bon affichage qui permette également d'entrer la réponse 
Dans ce jeu le but est de trouver le pays associé à son drapeau. Chaque drapeau est affiché accompagné d'un champs de texte pour rentrer le nom du pays et d'un bouton valider.
Le joueur peut sélectionner son pseudo et le zone géographique sur laquelle il souhaite jouer(Europe, Asie, Afrique, Amérique, Monde, Océanie).
Le but final de ce jeu est d'avoir un message de validation ou d'erreur quand on valide un nom de pays et la même sidebar que pour le jeu des capitales mais nous n'avons pas réussi ces parties là.
Pour le moment nous ne pouvons pas rentrer d'information dans les input et la validation ne peut donc pas être effectué, cela est dû à un manque de temps et un problème d'IDE.

## Structure du Projet

Il nous a semblé assez intuitif de séparer les différents éléments de notre projet, pour une meilleure lisibilité, une plus simple pérennisation et une meilleure manière de faire.

### lib/

Voici le repertoire lib similaire au dossier src dans un projet Java, c'est dans ce dossier que nous avons implété l'ensemble de notre application et de ses fonctionnalités dont voici une explication : 

### blocs

Ce repertoire contient le fichier '*player_cubit*' qui est le bloc cubit de notre application. Il contient la liste des joueurs ainsi que des méthodes pour ordonner les joueurs selon leurs scores et pour en ajouter. Un bloc cubit permet d'avoir accès aux données qu'il contient depuis toutes les pages comprises dans le BlocBuilder du bloc cubit, évitant ainsi de devoir envoyer les informations d'une page à l'autre, devoir raffraîchir et tout autre actions énergivores et faisant perdre du temps. Ici, lorsque les éléments compris dans le cubit sont mis à jour il le sont pour toutes les pages qui y ont accès.

Pour plus d'informations voir [flutter_bloc]([https://pub.dev/packages/flutter_bloc]). 

### models

Ce répertoire contient les différents modèles utilisés lors de ce projet : 
- 'Country' : modèle d'un pays prenant comme argument un nom (String), une capitale (String), une position(LatLng) et un drapeau (String) 
- 'Player' : modèle d'un joueur prenant comme argument un username (String), un scoreCapitals (int), un scoreFlags (int), un timeCapitals (String), un timeFlags (String), un hasHighscoreCapitals (bool) et un hasHighscoreFlags (bool)

Pour une meilleure compréhension voir [Captures d'écran](#capture-decran-models)

### repository
POUR BASTIEN


## Difficultés Rencontrées
Le cours étant bien structuré, les TPs complets et bien expliqués pas à pas 
Description des difficultés que vous avez rencontrées lors du développement et des solutions que vous avez trouvées.

## Captures d'écran

Ajoutez ici des captures d'écran de votre application pour montrer son apparence et son fonctionnement.

## Fonctionnalités

Listez ici les principales fonctionnalités de votre application.

## Installation

Expliquez comment installer votre application.

## Utilisation

Expliquez comment utiliser votre application une fois qu'elle est installée.

## Dépendances

Listez les principales dépendances de votre projet.

- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter)
- ...

## Contributions

Indiquez comment les personnes peuvent contribuer à votre projet.

## Licence


## 

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
