# zermelo.dart
Dit is een Zermelo API wrapper voor Flutter apps.

## In actie
Ik heb deze libary geschreven voor [https://github.com/Netlob/zeta](Zeta) (die app is discontinued want ik heb zelf geen Zermelo lol)
![screenshots](https://media.discordapp.net/attachments/600450283423662082/702582680780275753/New_Project_5.png "Screenshots")

## Hoe te gebruiken
Ik schrijf binnenkort wel ff een complete handleiding, maar eigenlijk spreekt alles voor zich. 
De intellisense van Flutter/Dart Dev Tools legt het ook allemaal voor je uit 

Hier is de login alvast:
```dart
dynamic accessToken = await Zermelo.getAccessToken(school, code);
Zermelo zermelo = Zermelo.getAPI(school, accessToken);
User currentUser = await zermelo.users.get(id: "~me");
```

Rooster voor aankomende week fetchen:
```dart
List<Day> appointments = await zermelo.appointments.get(
  DateTime.now(),
  DateTime.now().add(
    Duration(days: 7),
  ),
);
```
