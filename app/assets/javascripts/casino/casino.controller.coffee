app = angular.module('Casino')

app.controller('MainController', ['$http', 'PokerTablesService', 'UserService', 'Notification', ($http, PokerTablesService, UserService, Notification)->
  vm = this
  vm.user = { poker_table_ids: [] }

  notify = (response)->
    Notification.error(response.data.alert) if response.data.alert
    Notification.success(response.data.notice) if response.data.notice

  showErrors = (errors)->
    vm.errors = errors

  # Receive available poker tables
  getPokerTables = ->
    PokerTablesService.getPokerTables().then (response)->
      vm.pokerTables = response.data
      notify(response)
    ,(response)->
      notify(response)

  init = ->
    getPokerTables()

  init()

  vm.submitForm = ->
    UserService.setUser(vm.user)
    .then (response)->
      notify(response)
      showErrors(response.data.errors)
      getPokerTables()
    ,(response)->
      notify(response)
      showErrors(response.data.errors)
      getPokerTables()

  return vm
])