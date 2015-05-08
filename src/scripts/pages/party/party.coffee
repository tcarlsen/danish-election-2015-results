.controller "PartyController", ($scope, $http, $routeParams) ->
  apiUrl = "landet/#{$routeParams.party}"

  if $routeParams.path and $routeParams.id
    apiUrl = "#{$routeParams.path}/#{$routeParams.id}/#{$routeParams.party}"

  $scope.json = $scope.json or {}

  $http.get "#{apiIp}/#{apiUrl}"
    .success (data) ->
      $scope.json.party = data
    .error (data, status, headers, config) ->
      return
