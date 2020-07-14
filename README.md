
#  Meep App

## El Objetivo

Obtener los recursos (moto, bicis, paradas de bus, metro, ...) disponibles dado un "marco" (lowerLeftLatLon=38.711046,-9.160096&upperRightLatLon=38.739429,-9.137115) y una zona (lisboa). Puede utilizarse la llamada directamente. La idea es que una vez realizada la llamada, la app sea capaz de pintar sobre el mapa los diferentes recursos utilizando la librería de Google Maps.


## ¿Qué nos gustaría ver?
· Swift
· Arquitectura
· Llamada al endpoint
· Pintar markers sobre el mapa con la librería de Google Maps por defecto. Identificar los diferentes recursos por color según el companyZoneId
· Detalle por defecto al pulsar sobre un marker
· Extra: si el usuario se mueve por el mapa, refrescar los puntos



## Compile instructions (Xcode version, used flags...)

* Xcode verision used: Version 11.4.1 (11E503a)
* Just select your device or iOS/iPad OS emulator and test the app  
* Architecture implemented: Model-View-Controller or MVC pattern for app development
* The files in the Project Navigator are divided in Model, View and Controllers folders, where you can find the files for each section respectively



## ¿Qué Hace la App?

La app detecta la ubicación del usuario y muestra los servicios de transporte disponibles en el marco otorgado por la API. Se muestran los marcadores con diferentes colores dependiendo del código del ZoneID, (es decir, si hay 6 zoneIDs, se asignará a cada zoneID un color al azar, y todos los marcadores que contengan ese zoneID se mostrarán del mismo color en el mapa). 


## Observations/Feedback (para el desarrollador)
