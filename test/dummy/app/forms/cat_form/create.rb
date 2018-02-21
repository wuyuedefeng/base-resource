module CatForm
  class Create < Reform::Form
    model :cat

    property :name

    validates :name, presence: true, length: { maximum: 40 }
  end
end