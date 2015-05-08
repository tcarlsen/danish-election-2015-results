.config ($routeProvider) ->
  $routeProvider
    .when "/",
      templateUrl: "map.html"
      controller: "MapController"
    .when "/resultater/landet/:party",
      templateUrl: "party.html"
      controller: "PartyController"
    .when "/resultater/:path/:id?",
      templateUrl: "table.html"
      controller: "TableController"
    .when "/resultater/:path/:id/:party",
      templateUrl: "party.html"
      controller: "PartyController"
    .otherwise "/"
