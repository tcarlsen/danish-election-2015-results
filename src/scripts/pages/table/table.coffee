.controller "TableController", ($scope, $http, $routeParams) ->
  apiUrl = $routeParams.path
  apiUrl+= "/#{$routeParams.id}" if $routeParams.id

  $scope.json = $scope.json or {}

  $http.get "//IP-ADRESS/#{apiUrl}"
    .success (data) ->
      $scope.json.table = data
    .error (data, status, headers, config) ->
      return
