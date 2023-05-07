# Membres du goupe
- Randrianarivelo Herimanarivo Finoana Mandresy
- Rasoaharisoa Nantenaina Zotoavina
- Rakotoarison Harilanto Danih Stéphane

# Objectifs du projet

Réalisation d'un projet qui consiste à créer une plateforme qui permettra aux utilisateurs de créer des parcours touristiques.

# Les entités

## Parcours

Ces parcours sont identifiés par un titre, une description et font référence à plusieurs **Illustrations** et contiennent plusieurs **Poi** (point of interest)

Un parcours pourra être édité par son créateur (**Utilisateur**) ou l'un des modérateurs (**Utilisateur**) qui aura été ajouté à ce parcours

## Poi

Il s'agit d'un lieu, un monument, un point de passage et il est identifié par un titre, une description, une latitude et une longitude afin d'être capable de le placer sur une carte. Il fera lui aussi référence à plusieurs **Illustrations** ayant pour but de qualifier visuellement l'élément.

## Illustration

Il s'agit simplement d'une illustration, une image, identifiée par un simple nom de fichier, ce nom de fichier sera utilisé en conjonction avec des chemins stockés dans les fichiers de configuration pour composer le chemin interne (path) et le chemin externe (url)

## Utilisateur

Un utilisateur identifié sera capable de s'identifier sur la plateforme et pourra créer ses **Parcours** et **Pois**

# Ce qui est attendu

## Backend

Production d'une plateforme permettant de ...
- Créer
- Voir de manière unitaire ou en liste
- Modifier
- Supprimer

  ... des **Parcours** ainsi que des **Pois**

## Côté Frontend
Nous avons conçu un nouveau modèle de template qui n'était pas à l'origine de l'application. 
Ce modèle repose sur du Bootstrap et des personnalisations CSS poussées pour l'ensemble des pages.

## Api

Nous avons produit une API REST répondant aux requêtes suivantes :
- GET, PUT, PATCH et DELETE sur /api/parcours/{id}
- GET, POST sur /api/parcours
- GET, PUT, PATCH et DELETE sur /api/poi/{id}
- GET, POST sur /api/pois

Les requêtes sont faites avec un corps en JSON et la réponse peut être alternativement du JSON ou du XML selon l'encodage demandé lors de l'appel

Les réponses  retournent les codes d'erreur appropriés accompagnés de messages lorsque le problème n'est pas trivial

## Tests
En ce qui concerne les tests de l'API, nous avons implémenté une serie de test avec un test valide et des tests invalides pour chaque point d'entrée
Pour cela, nous avons choisi **Postman**.

***NB: la collection postman se trouve à la racine du projet***
Nom de la collection postman: ***TP-Grails.postman_collection.json***

## Documentation de l'api

### Parcours
#### Get un parcour

```http
  GET /api/parcour/{id}
```

| Parameter | Type     | Description                             |
|:----------|:---------|:----------------------------------------|
| `id`      | `string` | **Required**. L'identifiant du parcours |

#### Delete un parcour

```http
  DELETE /api/parcour/{id}
```

| Parameter | Type     | Description                             |
|:----------|:---------|:----------------------------------------|
| `id`      | `string` | **Required**. L'identifiant du parcours |


#### Update un parcour(tous les attributs)

```http
  PUT /api/parcour/{id}
```

| Parameter     | Type     | Description                                                             |
|:--------------|:---------|:------------------------------------------------------------------------|
| `id`          | `string` | **Required**. L'identifiant du parcour                                  |
| `title`       | `string` | **Required**. Le titre du parcour(5 à 55 caractères), non vide          |
| `description` | `string` | **Required**. La description du parcour, non vide                       |
| `moderateur`  | `string` | **Required**. Les identifiants des modérateurs séparés par des virgules |
| `illus`       | `files`  | **Required**. Les images pour illustrations du parcour                  |
| `poi`         | `string` | **Required**. Les identifiants des pois séparés par des virgules        |


#### Update un parcour(title et description)

```http
  PATCH /api/parcour/{id}
```

| Parameter     | Type     | Description                                                    |
|:--------------|:---------|:---------------------------------------------------------------|
| `id`          | `string` | **Required**. L'identifiant du parcours                        |
| `title`       | `string` | **Required**. Le titre du parcour(5 à 55 caractères), non vide |
| `description` | `string` | **Required**. La description du parcour, non vide              |

#### Create un parcour

```http
  POST /api/parcours
```

| Parameter     | Type     | Description                                                             |
|:--------------|:---------|:------------------------------------------------------------------------|
| `title`       | `string` | **Required**. Le titre du parcour (5 à 55 caractères), non vide         |
| `description` | `string` | **Required**. La description du parcour, non vide                       |
| `moderateur`  | `string` | **Required**. Les identifiants des modérateurs séparés par des virgules |
| `illus`       | `files`  | **Required**.Les images pour illustrations du parcour                   |
| `poi`         | `string` | **Required**. Les identifiants des pois séparés par des virgules        |

#### Get la liste des parcours avec pagination

```http
  GET /api/parcours
```

| Parameter    | Type     | Description                                         |
|:-------------|:---------|:----------------------------------------------------|
| `page`       | `number` | **Required**. La page pour la pagination            |
| `size`       | `number` | **Required**. Le nombre de parcour pour chaque page |


### Poi

#### Get un poi

```http
  GET /api/poi/{id}
```

| Parameter | Type     | Description                        |
| :-------- | :------- |:-----------------------------------|
|   `id`    | `string` | **Required**. L'identifiant du poi |

#### Delete un poi

```http
  DELETE /api/poi/{id}
```

| Parameter | Type     | Description                        |
| :-------- | :------- |:-----------------------------------|
|   `id`    | `string` | **Required**. L'identifiant du poi |

#### Update un poi(tous les attributs)

```http
  PUT /api/poi/{id}
```

| Parameter       | Type     | Description                                                                     |
|:----------------|:---------|:--------------------------------------------------------------------------------|
| `id`            | `string` | **Required**. L'identifiant du poi                                              |
| `title`         | `string` | **Required**. Le titre du poi(5 à 55 caractères), non vide                      |
| `description`   | `string` | **Required**. La description du poi, non vide                                   |
| `pathwayId`     | `string` | **Required**. L'identifiant du pathway du poi                                   |
| `illustrations` | `files`  | Les images pour illustrations du poi                                            |
| `lat`           | `number` | La latitude du poi                                                              |
| `lng`           | `number` | La longitude du poi                                                             |


#### Update un poi(title et desrciption)

```http
  PATCH /api/poi/{id}
```

| Parameter       | Type     | Description                                                   |
|:----------------|:---------|:--------------------------------------------------------------|
| `id`            | `string` | **Required**. L'identifiant du poi                            |
| `title`         | `string` | **Required**. Le titre du poi(5 à 55 caractères), non vide    |
| `description`   | `string` | **Required**. La description du poi, non vide                    |

#### Save un poi

```http
  POST /api/pois
```

| Parameter       | Type     | Description                                                 |
|:----------------|:---------|:------------------------------------------------------------|
| `title`         | `string` | **Required**. Le titre du poi (5 à 55 caractères), non vide |
| `description`   | `string` | **Required**. La description du poi, non vide                  |
| `pathwayId`     | `string` | **Required**. L'identifiant du pathway du poi               |
| `illustrations` | `files`  | Les images pour illustrations du poi                        |
| `lat`           | `number` | La latitude du poi                                          |
| `lng`           | `number` | La longitude du poi                                         |

#### Get une liste de pois

```http
  GET /api/pois
```

| Parameter | Type     | Description                |
|:----------|:---------|:---------------------------|
| `page`    | `number` | La page pour la pagination |


# Branche GIT


# Livraison
Comme convenu, nous avons livré sur le Github Classroom qui nous a été communiqué.
- La branche ***main*** contienne la version finale du projet.
- La totalité des fonctionnalités attendues ont été developpées.
- La collection postman pour les tests de l'api se trouve à la racine du projet
- La vidéo de démonstration est également accessible en suivant ce lien : https://www.youtube.com/watch?v=zYwTUv5q_Vk

# Environnement de développement
- java 8
- Grails 5.3.2