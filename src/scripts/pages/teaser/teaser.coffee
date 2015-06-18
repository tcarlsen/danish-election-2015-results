.controller "TeaserController", ($scope, $http, $timeout, $routeParams) ->
  doubleClickCheck = false
  enableMouseover = false

  $scope.json = $scope.json or {}
  $scope.json.map = {}
  $scope.appUrl = "http://#{$routeParams.url.replace('-', '/')}"

  $scope.toggleshowMan = (value) ->
    return if enableMouseover is false

    if value is true or value is false
      $scope.showMan = value
    else if !doubleClickCheck
      doubleClickCheck = true
      $scope.showMan = !$scope.showMan

      $timeout ->
        doubleClickCheck = false
      , 500

  $http.get "#{apiIp}/map"
    .success (data) ->
      $scope.json.map = data

      if data.votes_counted_pct >= 95 and data.blue_block.mandates isnt 0
        $scope.showMan = true
        enableMouseover = true
    .error (data, status, headers, config) ->
      return
