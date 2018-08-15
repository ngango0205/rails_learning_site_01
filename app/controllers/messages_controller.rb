class MessagesController < ApplicationController
  def show_chat
    @user_chat = User.find_by id: params[:id]
    unless @room =
        ChatRoom.find_by(name: current_user.id.to_s + @user_chat.id.to_s) ||
        @room = ChatRoom.find_by(name: @user_chat.id.to_s + current_user.id.to_s)
        @room = current_user.chat_rooms
          .create(name: current_user.id.to_s + @user_chat.id.to_s)
        RoomUserRelation.create chat_room_id: @room.id, user_id: @user_chat.id
    end
    respond_to do |format|
      format.js
    end
  end
end
