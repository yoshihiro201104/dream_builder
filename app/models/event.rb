class Event < ApplicationRecord
  belongs_to :group
  belongs_to :user # イベント作成者
end
