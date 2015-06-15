.controller "MapController", ($scope, $http, $timeout) ->
  doubleClickCheck = false

  $scope.json = $scope.json or {}
  $scope.json.map = {}

  $scope.detectmobile = ->
    if navigator.userAgent.match(/Android/i) or navigator.userAgent.match(/webOS/i) or navigator.userAgent.match(/iPhone/i) or navigator.userAgent.match(/iPad/i) or navigator.userAgent.match(/iPod/i) or navigator.userAgent.match(/BlackBerry/i) or navigator.userAgent.match(/Windows Phone/i)
      true
    else
      false

  $scope.toggleShowPct = ->
    if !doubleClickCheck
      doubleClickCheck = true
      $scope.showPct = !$scope.showPct

      $timeout ->
        doubleClickCheck = false
      , 500

  $http.get "#{apiIp}/map"
    .success (data) ->
      $scope.json.map = data
    .error (data, status, headers, config) ->
      return

  socket.on "votes_counted_pct", (message) ->
    $scope.$apply ->
      $scope.json.map.votes_counted_pct = message.result

  socket.on "blocks", (message) ->
    $scope.$apply ->
      $scope.json.map.blue_block = message.result.blue_block
      $scope.json.map.red_block = message.result.red_block

  socket.on "parties", (message) ->
    $scope.$apply ->
      $scope.json.map.parties = message.result

  socket.on "constituency", (message) ->
    $scope.$apply ->
      $scope.json.map.newConstituency = message.result

  socket.on "latest_votes_counted_complete", (message) ->
    $scope.$apply ->
      $scope.json.map.latest_votes_counted_complete.unshift(message.result)
