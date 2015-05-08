.config ($routeProvider) ->
  $routeProvider
    .when "/",
      templateUrl: "partials/map.html"
      controller: "MapController"
    .when "/resultater/landet/:party",
      templateUrl: "partials/party.html"
      controller: "PartyController"
    .when "/resultater/:path/:id?",
      templateUrl: "partials/table.html"
      controller: "TableController"
    .when "/resultater/:path/:id/:party",
      templateUrl: "partials/party.html"
      controller: "PartyController"
    .otherwise "/"
