class MembersController < ApplicationController
  before_filter :authenticate_member!
  before_filter :is_admin?, :only => [:create, :new]
  before_filter :can_edit?, only: [:edit, :update]
  before_filter :can_destroy?, :only => [:destroy]
  # GET /members
  # GET /members.json
  def index
    @members = current_member.house.members

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
    @member = Member.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/new
  # GET /members/new.json
  def new
    @member = Member.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/1/edit
  def edit
    @member = Member.find(params[:id])
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(params[:member])
    @member.house = current_member.house

    respond_to do |format|
      if @member.save
        format.html { redirect_to root_url, notice: 'Member was successfully created.' }
        format.json { render json: @member, status: :created, location: @member }
      else
        format.html { render action: "new" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /members/1
  # PUT /members/1.json
  def update
    @member = Member.find(params[:id])

    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member = Member.find(params[:id])
    @member.destroy

    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :no_content }
    end
  end

  private
  def can_edit?
     member = Member.find(params[:id])
     return if member.id == current_member.id
     return if member.is_member_of?(current_member.house) and current_member.is_admin?
     redirect_to new_member_session_path
  end

  def can_destroy?
    member = Member.find(params[:id])
    return if member.is_member_of?(current_member.house) and current_member.is_admin?
    redirect_to new_member_session_path 
  end

  def is_admin?
    redirect_to new_member_session_path unless current_member.is_admin?
  end
end
