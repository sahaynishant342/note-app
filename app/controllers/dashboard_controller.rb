class DashboardController < ApplicationController
  before_action :is_logged_in?, only: [:show]

  def show
    # get the list of all notes for current user
    @user = User.find session[:user_id]

    notes_for_user = @user.notes.order('updated_at DESC')

    @notes_summary = Array.new
    notes_for_user.each do |curr_note|
      note_hash = Hash.new
      note_lines = curr_note.text.split("<br>")
      note_hash["title"] = note_lines[0]
      note_hash["one_line_summary"] = (note_lines.size > 1 ? note_lines[1] : "")
      note_hash["last_modified"] = curr_note.updated_at
      @notes_summary << note_hash
    end

    @last_note = notes_for_user.first
  end

  def save_note
    # update note if note_id present else create it
    @user = User.find session[:user_id]
    text_to_be_saved = params[:note_text].gsub("/r/n", "<br>")
    @user.notes.create(:text => text_to_be_saved)
    redirect_to root_path
  end


  private

  def is_logged_in?
    if session[:user_id] == nil
      # TODO: show flash
      redirect_to root_path
    end
  end
end
