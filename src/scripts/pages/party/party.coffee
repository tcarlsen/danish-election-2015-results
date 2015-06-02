.controller "PartyController", ($scope, $http, $routeParams) ->
  apiUrl = "landet/#{$routeParams.party}"

  if $routeParams.path and $routeParams.id
    apiUrl = "#{$routeParams.path}/#{$routeParams.id}/#{$routeParams.party}"

  $scope.json = $scope.json or {}

  $scope.changeOrder = (order) ->
    if $scope.order is order
      $scope.reverse =! $scope.reverse
    else
      $scope.order = order
      $scope.reverse = false

  $http.get "#{apiIp}/#{apiUrl}"
    .success (data) ->
      $scope.json.party = data
    .error (data, status, headers, config) ->
      return
