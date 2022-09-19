  module User::NotificationsHelper
    def unchecked_notificatons
      @notifications = current_user.passive_notifications.where(checked: false)
    end
  end
