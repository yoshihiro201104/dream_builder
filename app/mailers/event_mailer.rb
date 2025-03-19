class EventMailer < ApplicationMailer
  def notify_members(event, user)
    @event = event
    @group = event.group
    @user = user

    mail(
      to: @group.users.pluck(:email),  # グループに所属するメンバー全員のメールアドレスを取得
      subject: "[#{@group.name}] 新しいイベント: #{@event.title}" # メールの件名をイベントタイトルにする
    )
  end
end
