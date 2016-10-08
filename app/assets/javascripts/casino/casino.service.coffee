app = angular.module('Casino')

app.service('PokerTablesService', ['$http', ($http)->
  service = this

  service.getPokerTables = ->
    $http({
      method: 'GET'
      url: '/poker_tables'
    })

  return service
])

app.service('UserService', ['$http', ($http)->
  service = this

  service.setUser = (user)->
    $http
      method: 'PUT'
      url: '/user_update'
      headers: {'Content-Type': 'application/x-www-form-urlencoded'}
      data: $.param({user: user})

  return service
])