class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy, :delete_by_receipient]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.where({from_user_id: current_user.id}).order("created_at desc")
  end

  def show_all
    @messages = Message.all.order("from_user_id asc").order("created_at desc") # TODO: if user is admin
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.from_user_id = current_user.id
    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_path, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to message_path(@message), notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #this one is a bit strange since this method is standing in the pointview as a reader.
  def gotoinbox
    @messages = Message.where({to_user_id: current_user.id, visible_to_receipient: true})
  end

  def delete_by_receipient
    @message.visible_to_receipient = false
    @message.save!
    flash[:notice] = "Message deleted."
    redirect_to "/inbox"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id]) if params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:from_user_id, :to_user_id, :title, :body)
    end
end
