class EnemiesController < ApplicationController
  def update
    if @enemy.update(enemy_params)
      render json: @enemy, status: :ok
    else
      render json: { errors: @enemy.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @enemy.destroy
    head 204
  end

  def index
    @enemies = Enemy.all

    render json: @enemies, status: :ok
  end

  def show
    @enemy = Enemy.find(params[:id])

    rescue ActiveRecord::RecordNotFound => e
      render json: { message: e.message }, status: :not_found

    render json: @enemy, status: :ok
  end
  
  def create
    if @enemy.create(enemy_params)
      render json: @enemy, status: 204
    else
      render json: { errors: @enemy.errors }, status: :unprocessable_entity
    end
  end

  before_action :set_enemy, except: [:index, :create]

  private
    
  def enemy_params
    params.permit(:name, :power_base, :power_step, :level, :kind)
  end

  def set_enemy
    @enemy = Enemy.find(params[:id])

    rescue ActiveRecord::RecordNotFound => e
      render json: { message: e.message }, status: :not_found
  end
end
