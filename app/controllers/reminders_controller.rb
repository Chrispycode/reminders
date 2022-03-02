class RemindersController < ApplicationController
  before_action :set_reminder, :authorize_access, only: %i[ show edit update destroy ]
  before_action :authorize

  def index
    @reminders = current_user.reminders
  end

  def show; end

  def new
    @reminder = Reminder.new
  end

  def edit; end

  def create
    @reminder = Reminder.new(reminder_params)

    if @reminder.save
      redirect_to reminder_url(@reminder), notice: "Reminder was successfully created."
    else
      flash.now.alert = @reminder.better_errors
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @reminder.update(reminder_params)
      redirect_to reminder_url(@reminder), notice: "Reminder was successfully updated."
    else
      flash.now.alert = @reminder.better_errors
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reminder.destroy
    redirect_to reminders_url, notice: "Reminder was successfully destroyed."
  end

  private
    def set_reminder
      @reminder = Reminder.find(params[:id])
    end

    def reminder_params
      params.require(:reminder).permit(:title, :body, :user_id, :scheduled_time, :scheduled_day)
    end

    def authorize_access
      render file: "public/404.html", status: :unauthorized unless @reminder.user == current_user
    end
end
