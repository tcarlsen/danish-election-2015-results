.config ($routeProvider) ->
  $routeProvider
    .when "/map",
      templateUrl: "partials/map.html"
      controller: "MapController"
    .when "/table/:path/:id?",
      templateUrl: "partials/table.html"
      controller: "TableController"
    .when "/party/:id",
      templateUrl: "partials/party.html"
      controller: "PartyController"
    .otherwise "/map"
