# frozen_string_literal: true

require 'yaml'

class Config
  def initialize
    @item_path
    @page_path
    @cost_path
    @image_path
    @shop_path
    @available_path
    @id_path
    @name_path
    @last_path
    proceed_yaml
  end

  attr_accessor :item_path, :page_path,
                :cost_path, :image_path,
                :shop_path, :available_path,
                :id_path, :name_path, :last_path

  def proceed_yaml
    yaml = YAML.load_file('config.yaml')
    @item_path = yaml[0]['categorypage']['itempath']
    @page_path = yaml[0]['categorypage']['pagepath']
    @last_path = yaml[0]['categorypage']['lastpath']
    @cost_path = yaml[1]['itempage']['costpath']
    @image_path = yaml[1]['itempage']['imagepath']
    @id_path = yaml[1]['itempage']['idpath']
    @shop_path = yaml[1]['itempage']['shoppath']
    @name_path = yaml[1]['itempage']['namepath']
    @available_path = yaml[1]['itempage']['available']
  end
end
