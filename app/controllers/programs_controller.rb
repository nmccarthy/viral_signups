class ProgramsController < ApplicationController
  require 'net/https'
  
  # GET /programs
  # GET /programs.json
  def index
    @programs = Program.where(:user_id => current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @programs }
    end
  end

  # GET /programs/1
  # GET /programs/1.json
  def show
    @program = Program.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @program }
    end
  end

  # GET /programs/new
  # GET /programs/new.json
  def new
    @program = Program.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @program }
    end
  end

  # GET /programs/1/edit
  def edit
    @program = Program.find(params[:id])
    @program_users = @program.users
  end

  # POST /programs
  # POST /programs.json
  def create
    @program = Program.new(params[:program])
    @program.user_id = current_user.id
    token = current_user.access_token

    respond_to do |format|
      if @program.save
        payload = JSON.generate(
        {
          :activity   => {
            :actor    => {
              :name   => current_user.full_name,
              :email  => current_user.email
            },
            :action   => 'create',
            :object   => {
              :url    => 'http://localhost:3000/programs/' + @program.id.to_s,
              :type   => 'page',
              :title  => @program.name + " signup form"
            }
          }
        })

        connection = Net::HTTP.new("www.yammer.com", 443) # Create the connection to Yammer API
        connection.use_ssl = true # Enable SSL

        raw_response = connection.post("https://www.yammer.com/api/v1/activity.json?access_token=#{token}", payload, {
          "Content-Type" => "application/json",
          "Content-Length" => payload.length.to_s
        })

        format.html { redirect_to  "/programs", notice: 'Program was successfully created.' }
        format.json { render json: "/programs", status: :created, location: @programs }
      else
        format.html { render action: "new" }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /programs/1
  # PUT /programs/1.json
  def update
    @program = Program.find(params[:id])

    respond_to do |format|
      if @program.update_attributes(params[:program])
        format.html { redirect_to @program, notice: 'Program was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programs/1
  # DELETE /programs/1.json
  def destroy
    @program = Program.find(params[:id])
    @program.destroy

    respond_to do |format|
      format.html { redirect_to programs_url }
      format.json { head :ok }
    end
  end
  
  def signup
    @program = Program.find(params[:id])
    @program.users << current_user
    token = current_user.access_token
    
    respond_to do |format|
      payload = JSON.generate(
      {
        :activity   => {
          :actor    => {
            :name   => current_user.full_name,
            :email  => current_user.email
          },
          :action   => 'update',
          :object   => {
            :url    => 'http://localhost:3000/programs/' + @program.id.to_s,
            :type   => 'page',
            :title  => @program.name + " signup form"
          },
          :message => 'Signed Up'
        }
      })

      connection = Net::HTTP.new("www.yammer.com", 443) # Create the connection to Yammer API
      connection.use_ssl = true # Enable SSL

      raw_response = connection.post("https://www.yammer.com/api/v1/activity.json?access_token=#{token}", payload, {
        "Content-Type" => "application/json",
        "Content-Length" => payload.length.to_s
      })
      format.html { redirect_to '/thanks' }
      format.json { head :ok }
    end
  end
  
  def thanks
  end
end
