module CatForm
  class Update < Reform::Form
    model :cat

    property :name

    validates :name, presence: true
  end
end