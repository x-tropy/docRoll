class ScriptsController < ApplicationController
  before_action :set_script, only: %i[ show edit update destroy ]

  # GET /scripts or /scripts.json
  def index
    @scripts = Script.all
  end

  # GET /scripts/1 or /scripts/1.json
  def show
  end

  # GET /scripts/new
  def new
    @script = Script.new
  end

  # GET /scripts/1/edit
  def edit
  end

  # POST /scripts or /scripts.json
  def create
    @script = Script.new(script_params)

    respond_to do |format|
      if @script.save
        format.html { redirect_to @script, notice: "Script was successfully created." }
        format.json { render :show, status: :created, location: @script }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @script.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scripts/1 or /scripts/1.json
  def update
    respond_to do |format|
      if @script.update(script_params)
        format.html { redirect_to @script, notice: "Script was successfully updated." }
        format.json { render :show, status: :ok, location: @script }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @script.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scripts/1 or /scripts/1.json
  def destroy
    @script.destroy!

    respond_to do |format|
      format.html { redirect_to scripts_path, status: :see_other, notice: "Script was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_script
      @script = Script.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def script_params
      params.expect(script: [ :title, :body ])
    end
end
