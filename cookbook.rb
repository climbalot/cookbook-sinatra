require 'csv'

class Cookbook
  
  def initialize(csv_file_path)
    @recipes = []
    @csv_file = csv_file_path
    @cookbook_csv = CSV.read(@csv_file) 
    unless @cookbook_csv.empty?
      @cookbook_csv.each do |recipe| 
        @recipes << Recipe.new(recipe[0], recipe[1], recipe[2], recipe[3], to_boolean(recipe[4]))
      end
    end
  end

  def to_boolean(str)
    str == 'true'
  end

  def all
    # returns recipes
    @recipes
  end

  def add_recipe(recipe)
    # add new recipe
    @recipes << recipe
    save_csv
  end

  def remove_recipe(recipe_index)
    # remove recipe
    @recipes.delete_at(recipe_index)
    save_csv
  end

  def mark_as_done(index)
    @recipes[index].mark_as_done
    save_csv
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      @recipes.each { |recipe| csv << [recipe.name, recipe.description, recipe.prep_time, recipe.difficulty, recipe.done] }
    end
  end
end

