class Public::EventsController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @event = Event.new
  end

  def create
    @group = Group.find(params[:group_id])
    @event = @group.events.build(event_params)

    if @event.save
      redirect_to group_event_path(@group, @event), notice: "イベントが通知されました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:id])
  end
  

  private

  def event_params
    params.require(:event).permit(:title, :comment)
  end
end
