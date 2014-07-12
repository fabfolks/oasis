class HousesController < ApplicationController
  before_filter :can_edit?, :except => [:index, :show]
  # GET /houses
  # GET /houses.json
  def index
    @houses = House.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @houses }
    end
  end

  # GET /houses/1
  # GET /houses/1.json
  def show
    @house = House.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @house }
    end
  end

  # GET /houses/1/edit
  def edit
    @house = House.find(params[:id])
  end

  # PUT /houses/1
  # PUT /houses/1.json
  def update
    @house = House.find(params[:id])

    respond_to do |format|
      if @house.update_attributes(params[:house])
        format.html { redirect_to @house, notice: 'House was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /houses/1
  # DELETE /houses/1.json
  private

  def can_edit?
    house = House.find(params[:id])
    redirect_to '/404.html' unless current_member.is_member_of?(house) and current_member.is_admin?
  end
end
