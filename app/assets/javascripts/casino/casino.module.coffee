app = angular.module('Casino', ['checklist-model', 'ui-notification'])

# Configuration for notifications
app.config ['NotificationProvider', (NotificationProvider)->
  NotificationProvider.setOptions({
    delay: 3000,
    startTop: 15,
    startRight: 10,
    verticalSpacing: 20,
    horizontalSpacing: 20,
    positionX: 'left',
    positionY: 'bottom'
  })
]