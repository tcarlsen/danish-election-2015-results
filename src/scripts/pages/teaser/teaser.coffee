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
      alert "Der var et problem med at skabe kontakt til vores server, prøv igen senere."

  socket.removeAllListeners()

  socket.on "votes_counted_pct", (message) ->
    $scope.$apply ->
      $scope.json.map.votes_counted_pct = message.result.votes_counted_pct

      if message.result.votes_counted_pct is 100
        $scope.showMan = true
        enableMouseover = true
      else
        $scope.showMan = false
        enableMouseover = false

  socket.on "blocks", (message) ->
    $scope.$apply ->
      $scope.json.map.blue_block = message.result.blue_block
      $scope.json.map.red_block = message.result.red_block

  socket.on "parties", (message) ->
    $scope.$apply ->
      $scope.json.map.parties = message.result
