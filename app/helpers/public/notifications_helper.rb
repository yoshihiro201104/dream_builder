module Public::NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "Goal"
      "フォローしている#{notification.notifiable.user.name}さんが#{notification.notifiable.title}を投稿しました"
    else
      "投稿した#{notification.notifiable.book.title}が#{notification.notifiable.user.name}さんにいいねされました"
    end
  end
end