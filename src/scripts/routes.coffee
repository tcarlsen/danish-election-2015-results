.config ($routeProvider) ->
  $routeProvider
    .when "/",
      templateUrl: "partials/map.html"
      controller: "MapController"
    .when "/resultater/:path/:id?",
      templateUrl: "partials/table.html"
      controller: "TableController"
    .when "/party/:id",
      templateUrl: "partials/party.html"
      controller: "PartyController"
    .otherwise "/"
