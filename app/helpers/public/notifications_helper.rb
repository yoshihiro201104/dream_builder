module Public::NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "Goal"
      "フォローしている#{notification.notifiable.user.name}さんが#{notification.notifiable.goal}を投稿しました"
    else
      "投稿した#{notification.notifiable.goal.title}が#{notification.notifiable.user.name}さんにいいねされました"
    end
  end
end